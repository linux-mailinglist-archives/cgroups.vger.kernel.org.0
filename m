Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D67CB59D
	for <lists+cgroups@lfdr.de>; Mon, 16 Oct 2023 23:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjJPVsk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 17:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjJPVsj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 17:48:39 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA7DB4
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 14:48:37 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41b19dda4c6so44631cf.1
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697492916; x=1698097716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMVpQQSTcdIVz3zyyuQiutrHUu+viri19bS81MO6lqg=;
        b=PuV2o6cGb2RD6HMjypIvPEw3noVZtVcJXsm89CYVniCWlALup5ooJi0wjQ1GB/k5te
         nQqZyJfsTmzGJLOkfIhWZ5wuMAhA6YGyPwE26hMcnOqkiV1O8es0/nYNX3w3nbYkymTw
         N5AIF55XDler52yw402BcbBJS96J0BqFR28Y33Zw8T3+Repz6h0QeFbod2V2/eZEat9L
         ZZ7qB1uMWB6Oar1Xr/8YwiNm0p4lxJMGUDFbn2VzWuZL4AYddlLnIwf8FlVLlVzOlVRB
         nda4QXPaLHv5pYlbluxXUAiLRvUzR4XF7HVpvztZCLUwlkJzgP3o7Vb5S63pDCAvcW7V
         71vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492916; x=1698097716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMVpQQSTcdIVz3zyyuQiutrHUu+viri19bS81MO6lqg=;
        b=IYvE5Gy+R0r2MA/b8px4vCyrq2np1PHVjUjNkfr53v/4VBuGXbQ3yJ5D/3gkIyUFPa
         jrJtNtcwBqRqJOOFs6bSiGZONaSgFfdXYvPz5HfGkMGryQX5rUABW6UZ5HgGn3likX1B
         OfAM0OMuOC/B0yj6QKrh+SWsK7p8m1Kc0Ifsm78DhMHBErIqhEw8F00dqSSNagG/GFe1
         inZouiLWmCAknF8z8pfN0UmS7tOrVZSGfUpa8MgkhlIJ6c4r3FZIoXUOkt0FNEytKSMQ
         mSd6JycmprT7yfYjkzwyfegWKDEOQcOBxbheIwqjobQWqB1ZUKjUohmUMdhnXwyPn4k0
         KpRA==
X-Gm-Message-State: AOJu0YyHQBiIGOWXhe3Up9ZT0663+kARzUcNQwLzZpt6D0FPYdD5KHGR
        PdlFPiQWU79xajOnmQzqXSBJFWcxcu0D9Wdaep94kg==
X-Google-Smtp-Source: AGHT+IG7r4JQkTY7QRBqLIn53rtDCeNYj8B29ETeTJVhjbNYJE0uNpHoKKYpN+DZJ7cFbu2Bj/lanINP3ELdKlEixiU=
X-Received: by 2002:a05:622a:478e:b0:418:1878:5b8c with SMTP id
 do14-20020a05622a478e00b0041818785b8cmr24567qtb.25.1697492916193; Mon, 16 Oct
 2023 14:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com> <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com> <20231007151607.GA24726@redhat.com>
 <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com> <20231008113602.GB24726@redhat.com>
 <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
 <e9165cd0-9c9d-1d1a-1c5b-402556a1a31f@huaweicloud.com> <CACGdZYLxnL91S4RxfvLmN8j3rcvbsqdkouj4Lgc05mnCo2fZSw@mail.gmail.com>
In-Reply-To: <CACGdZYLxnL91S4RxfvLmN8j3rcvbsqdkouj4Lgc05mnCo2fZSw@mail.gmail.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Mon, 16 Oct 2023 14:48:22 -0700
Message-ID: <CACGdZY+nmtRLeXi48z8J2QD5wFSVCuhFVRbzD9ktK5tXXrbxBw@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Li Nan <linan666@huaweicloud.com>,
        tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004e4c250607dc5eee"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--0000000000004e4c250607dc5eee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 1:06=E2=80=AFPM Khazhy Kumykov <khazhy@chromium.org=
> wrote:
>
> I mostly just want us to pick /something/, since 6.6-rc and the LTSs
> with the patch in question are busted currently. :)
>
And just to make it explicit: I believe Kaui's proposal is correct.

Khazhy

--0000000000004e4c250607dc5eee
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNQwggO8oAMCAQICEAGy8e6bI55p/yISlXXG
SrAwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzA3MTYw
NzQ1MTRaFw0yNDAxMTIwNzQ1MTRaMCIxIDAeBgkqhkiG9w0BCQEWEWtoYXpoeUBnb29nbGUuY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA84UGa4X1/brS7/2vQRLnjHc/oa9+4lri
stpvdNGyJgDZNvJouUxTihNXyW4exVS4rkaD+DjMOTcoxFy+KEAzrIzotas1NbZt4P7DTJ9Dp6/1
20YUAt9rnWmZNHmuzZNGlRYhzAAOaDkGhKFnULS1bItsuRmuPA1st6vd7GiVA00TiflQ7IYni7ZN
fd1TDheOc7OGHW6PcHPW0P0HGTzzvTpgTKQi4ojKre0fW/Yb0lZEVpBiadSj9MeDn5/f0yUpeFYD
fll7rnq2bPGOfS3JjwLalgVSl5Ho6txXv9vlJVYxgnAoNZsZJ2EHvsT7eUQYNHg5an0nClXZYIF7
p2YQGQIDAQABo4IB0jCCAc4wHAYDVR0RBBUwE4ERa2hhemh5QGdvb2dsZS5jb20wDgYDVR0PAQH/
BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAdBgNVHQ4EFgQUKmFDbOAVaL0O
2d1HymA53tUP1hUwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBADeZduKRV5+J7StRkfoY
hBDfCkyRbFphFmeJ+0A1fPxECLLkrXR2izyctzMAGZH2ceScAlECO1r3aEQcyx9n7/YlMc24ZF0I
++9b72/wv6J6POICeIj6MgschmHIUz4Rw4H5IdBLo62N0jBBzv2T9ASRAl7Yryl6tHUN5X5228Tt
3LJe5Gtb1cm22DdXBM3xnD7Kd59ls9j/tz5I+yEsLIK7zQk7hBt87a31T55CTVgMQZ4lTavG5vdz
vEb7YC0jFAT8SmYmtSOr+4aZJRIwVjXlI04Mfr3jcbqDnzfv0VgVp5UlzQK4aApofbSsSDeXsDR+
t30gEkeMNUvUqd6PaxYxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAGy8e6bI55p/yISlXXGSrAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIH6FAl/o
G2xTs+JUWQR85UDBxTjresTY9hsN2+MB9kWqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMTAxNjIxNDgzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDS4jCrF3CHWhODe649p60aQK6V
ElOaGWCQtGndJeL8N8Ea/6RvIRPK7oRoTcrv3dY45jLXpIfZqDo9t9vTxV1o0BxdIVAWA1iCT9fV
DQDlFetPoCnRDCjldW3gs5F88v74y/2Qzr+TvD6WU+3u1GCom+hYTvPH/C53PYojt1tM/PNbH+is
P9U3NkMKJsD0IWfruS+8+UmHr/IvvUi9YnjY7wpDZlATgG/vzID8uI026Z5BkHPCjYBKcv2Uh11w
yZOgqKIRteTKeMWP6kUe+vCpsS7G4j2DhSDV/YlbbgLoCuenx2s01J87nwyzy0583iPw2xKT/fyp
ocHaNoAkeQPw
--0000000000004e4c250607dc5eee--
