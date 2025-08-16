;; Decentralized Identity Verification Smart Contract

;; Define the contract owner
(define-constant system-admin 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM) ;; Replace with your address

;; Map to store user identities
(define-map profiles principal { 
    full-name: (string-utf8 100), 
    contact-email: (string-utf8 100), 
    validated: bool 
})

;; Error codes
(define-constant ERR_FORBIDDEN (err u1001))
(define-constant ERR_ALREADY_EXISTS (err u1002))
(define-constant ERR_MISSING (err u1003))

;; Function to register identity
(define-public (register-identity (full-name (string-utf8 100)) (contact-email (string-utf8 100)))
    (begin
        ;; Check if the caller already has an identity
        (asserts! (is-none (map-get? profiles tx-sender)) ERR_ALREADY_EXISTS)
        
        ;; Store the identity
        (map-set profiles tx-sender { full-name: full-name, contact-email: contact-email, validated: false })
        
        ;; Return success
        (ok true)
    )
)

;; Function to verify identity (only callable by contract owner)
(define-public (verify-identity (member principal))
    (begin
        ;; Ensure only the contract owner can verify identities
        (asserts! (is-eq tx-sender system-admin) ERR_FORBIDDEN)
        
        ;; Check if the user exists
        (asserts! (is-some (map-get? profiles member)) ERR_MISSING)
        
        ;; Update the verified status
        (map-set profiles member (merge (unwrap! (map-get? profiles member) ERR_MISSING) { validated: true }))
        
        ;; Return success
        (ok true)
    )
)

;; Function to get identity information
(define-read-only (get-identity (member principal))
    (begin
        ;; Fetch the identity
        (match (map-get? profiles member)
            profile (ok profile)
            (err ERR_MISSING)
        )
    )
)

;; Function to delete identity (only callable by the user)
(define-public (delete-identity)
    (begin
        ;; Ensure the caller has an identity
        (asserts! (is-some (map-get? profiles tx-sender)) ERR_MISSING)
        
        ;; Delete the identity
        (map-delete profiles tx-sender)
        
        ;; Return success
        (ok true)
    )
)