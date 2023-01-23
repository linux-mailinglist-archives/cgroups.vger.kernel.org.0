Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E386789C3
	for <lists+cgroups@lfdr.de>; Mon, 23 Jan 2023 22:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjAWVgq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Jan 2023 16:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAWVgp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Jan 2023 16:36:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D5530292
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 13:36:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m11so1101837pji.0
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 13:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGXvyQjwLmOy53oIzm1ZLaTMK3/o09Vv8V+chgSLdeY=;
        b=CcWptSLeFIccOdIwrrQruiIQVbfQw+qTyjT3yv+7o4oiOdtJnaGwyxjNF8KqV8JCPb
         EtEuwCUakT7bXDWuTHstKBBxFfx/NFD6nI++Zxx33wEt2LsDHWWFbVo+nWs5aJpvgbDt
         bcNjHlr2/smIeZ2DgR6hyv29jjDSqQQI+8Qj+9AAlhetLTyxbKX75Vw/uzLti5pjdjDD
         1gqqU5UtNkfvmUk9ZygMGK8+1jwTN9eFYCq597DzigUSvomN5c9XhKqAjmlcR+BL0bRb
         fkuAUTdTl6ZIMoENwrU3bfv6UbzvTXWAqgAlNJDWfnVuL4Hhf5bRgdVGoARAYxrNCCDe
         ljRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGXvyQjwLmOy53oIzm1ZLaTMK3/o09Vv8V+chgSLdeY=;
        b=H8HBHEu6dbmy6gDt7Mqt6dcYsoms43ZXSB2SXPuV0i73V2DKNAn+hdN4GvGMBrwsw5
         sGWSqdK+kN3FhHJsoWmy9578EdoJ556j2FP7gkwwDCN263kv62pTXojXj5GMHbtQ8g21
         W0HD5rY5q1IVbfFO9ZfFhJJuceAEd9O432ykNH520v3PEJ/PnLN4/4WSgZ0xMrRNBsVm
         GFOySOqJ2ssiiIh1bVX65HNmWPLTaHYNWwuvadDhDfdOaqyyfugotr7OrAg0bf3I+bZ9
         JAejWlSkNGNpQzhWRe4MyADWhWu48jzgIYsFLQDmMGTCxGHRSR4bVQvz3Zd5pZIIVUp9
         94/w==
X-Gm-Message-State: AFqh2ko1GCgvMrL1zXhMHn0j7LORl9JwWLMmxaefnCMQECjoGtLwBnkR
        rMCRrCQBehGuDaF1oz6Ns+GV9NIHrf4gM7KX+IlM
X-Google-Smtp-Source: AMrXdXsTqILQIvoKLSzn2vsOwuLpTkEPmSgexyL8bv143mvjcjNDhObnaFgjhL7UQHe0gGX5etBgH6e4mhBUZDn4fO0=
X-Received: by 2002:a17:90a:c784:b0:227:202b:8eaa with SMTP id
 gn4-20020a17090ac78400b00227202b8eaamr2957806pjb.147.1674509804015; Mon, 23
 Jan 2023 13:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com> <20230123191728.2928839-5-tjmercier@google.com>
In-Reply-To: <20230123191728.2928839-5-tjmercier@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Jan 2023 16:36:32 -0500
Message-ID: <CAHC9VhQtbTWXXy8mNxNDdukaAp6YB4CX5Xa6dvSZ_r4DhM2EXg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] security: binder: Add binder object flags to selinux_binder_transfer_file
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        jeffv@google.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 23, 2023 at 2:18 PM T.J. Mercier <tjmercier@google.com> wrote:
>
> Any process can cause a memory charge transfer to occur to any other
> process when transmitting a file descriptor through binder. This should
> only be possible for central allocator processes, so the binder object
> flags are added to the security_binder_transfer_file hook so that LSMs
> can enforce restrictions on charge transfers.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  drivers/android/binder.c            |  2 +-
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/lsm_hooks.h           |  5 ++++-
>  include/linux/security.h            |  6 ++++--
>  security/security.c                 |  4 ++--
>  security/selinux/hooks.c            | 13 ++++++++++++-
>  security/selinux/include/classmap.h |  2 +-
>  7 files changed, 25 insertions(+), 9 deletions(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3c5be76a9199..d4cfca3c9a3b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -88,6 +88,7 @@
>  #include <linux/bpf.h>
>  #include <linux/kernfs.h>
>  #include <linux/stringhash.h>  /* for hashlen_string() */
> +#include <uapi/linux/android/binder.h>
>  #include <uapi/linux/mount.h>
>  #include <linux/fsnotify.h>
>  #include <linux/fanotify.h>
> @@ -2029,7 +2030,8 @@ static int selinux_binder_transfer_binder(const struct cred *from,
>
>  static int selinux_binder_transfer_file(const struct cred *from,
>                                         const struct cred *to,
> -                                       struct file *file)
> +                                       struct file *file,
> +                                       u32 binder_object_flags)
>  {
>         u32 sid = cred_sid(to);
>         struct file_security_struct *fsec = selinux_file(file);
> @@ -2038,6 +2040,15 @@ static int selinux_binder_transfer_file(const struct cred *from,
>         struct common_audit_data ad;
>         int rc;
>
> +       if (binder_object_flags & BINDER_FD_FLAG_XFER_CHARGE) {
> +               rc = avc_has_perm(&selinux_state,
> +                           cred_sid(from), sid,
> +                           SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
> +                           NULL);
> +               if (rc)
> +                       return rc;
> +       }
> +
>         ad.type = LSM_AUDIT_DATA_PATH;
>         ad.u.path = file->f_path;
>
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index a3c380775d41..2eef180d10d7 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[] = {
>         { "tun_socket",
>           { COMMON_SOCK_PERMS, "attach_queue", NULL } },
>         { "binder", { "impersonate", "call", "set_context_mgr", "transfer",
> -                     NULL } },
> +                     "transfer_charge", NULL } },
>         { "cap_userns",
>           { COMMON_CAP_PERMS, NULL } },
>         { "cap2_userns",

My first take on reading these changes above is that you've completely
ignored my previous comments about SELinux access controls around
resource management.  You've leveraged the existing LSM/SELinux hook
as we discussed previously, that's good, but can you explain what
changes you've made to address my concerns about one-off resource
management controls?

-- 
paul-moore.com
