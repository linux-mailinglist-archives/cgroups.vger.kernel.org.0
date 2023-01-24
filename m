Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68BB678F73
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 05:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjAXEr3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Jan 2023 23:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjAXEr2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Jan 2023 23:47:28 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9465A38B42
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 20:47:26 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id m199so1734853ybm.4
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 20:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5+rk6gG92yU871Q18SGdLg7yIfDbgS5v3bi+1rCUbI=;
        b=aWyceTWtE5DTXNyf9TvC5uY4/OZwC8YyWYVPbtQZa82CqvSa6NLYy7WyPJWvo1gHfR
         qbqDg2g0l+Ahec3b15JPqyZBqEWwhusTLppzRnqY5x9zcHeYavXxKgYAg8mIW3k8ULE5
         sKYGam3VNwr5rFIaYa2weHMKPhAlUexGu6I7BsgaF2BY/zDAErUTVigE890Cwy6KLrLc
         9yqPI2WnnMdJHwF42k8jmH74XUPI11iHViGtCj+XOvHYb5av5UEmYLP4v0+hPOymIYpP
         lWNcJpvaBML6U8BIJzbtH/XxL8W2IM9HC5UZ/bhRzYNKonuqg2CbUJvEgWkhW0R7YNE1
         MdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5+rk6gG92yU871Q18SGdLg7yIfDbgS5v3bi+1rCUbI=;
        b=qrohsnIuUjwOxrIDAmPcKhs66d/CxHTz7xpYXwz+wTXvokD1qwkEJYmVcewL+VTrPp
         E9lGzLu731pQqA9h0Nlx39gqn0JuwHR3sfwaepmnNqNqZUhcGHGifFLq5AAX/s7C7c/W
         Dx4B+X5j+gXcmDH6OboKmsIAIo2vXyBiQwkrCx5zKuihmXoMPZCczoEnLIzqKzVmkAEJ
         fY83VxAeN8TLRiaTrUzW3a7V9NXSFUCTwRmj3SHLchUa3xbf7+pAnv9Atn1VPp9sljlF
         3x2GX4U7V8m6wY5iB28bVhKidkztlziAXe83vloU2xaK7kC07q5m2Cg+ng4zkklD3cSS
         OTaQ==
X-Gm-Message-State: AFqh2kosFOhuCwpQbRx9Qik9R0F9BjZQhzfgP/60V2HSlDyTcUivNpyf
        7R8CC09A8y6FYEWciqVxshxULNSQBUWck12tAVPFzA==
X-Google-Smtp-Source: AMrXdXuYdYgfPuS6e/ypCYP4fU7Onii28qxOTxo06MVE/ttY1OEfzR8WQcc4gqxY5GLV14tPPWAYGcO2P7+hD94HjyM=
X-Received: by 2002:a25:c00a:0:b0:733:4dbc:7215 with SMTP id
 c10-20020a25c00a000000b007334dbc7215mr3054103ybf.636.1674535645579; Mon, 23
 Jan 2023 20:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com>
 <20230123191728.2928839-5-tjmercier@google.com> <CAHC9VhQtbTWXXy8mNxNDdukaAp6YB4CX5Xa6dvSZ_r4DhM2EXg@mail.gmail.com>
 <CABdmKX0Jc3OTnSMv_GoL0eEo=7W9dP29+r5K=PfF84xAUHviBw@mail.gmail.com>
In-Reply-To: <CABdmKX0Jc3OTnSMv_GoL0eEo=7W9dP29+r5K=PfF84xAUHviBw@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 23 Jan 2023 20:47:14 -0800
Message-ID: <CABdmKX0EoAw+TYk29z1dJXtWekfw22KDQAkQPGiDAh8ojeKd1A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] security: binder: Add binder object flags to selinux_binder_transfer_file
To:     Paul Moore <paul@paul-moore.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 23, 2023 at 2:04 PM T.J. Mercier <tjmercier@google.com> wrote:
>
>
>
> On Mon, Jan 23, 2023 at 1:36 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Mon, Jan 23, 2023 at 2:18 PM T.J. Mercier <tjmercier@google.com> wrot=
e:
>> >
>> > Any process can cause a memory charge transfer to occur to any other
>> > process when transmitting a file descriptor through binder. This shoul=
d
>> > only be possible for central allocator processes, so the binder object
>> > flags are added to the security_binder_transfer_file hook so that LSMs
>> > can enforce restrictions on charge transfers.
>> >
>> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>> > ---
>> >  drivers/android/binder.c            |  2 +-
>> >  include/linux/lsm_hook_defs.h       |  2 +-
>> >  include/linux/lsm_hooks.h           |  5 ++++-
>> >  include/linux/security.h            |  6 ++++--
>> >  security/security.c                 |  4 ++--
>> >  security/selinux/hooks.c            | 13 ++++++++++++-
>> >  security/selinux/include/classmap.h |  2 +-
>> >  7 files changed, 25 insertions(+), 9 deletions(-)
>>
>> ...
>>
>> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> > index 3c5be76a9199..d4cfca3c9a3b 100644
>> > --- a/security/selinux/hooks.c
>> > +++ b/security/selinux/hooks.c
>> > @@ -88,6 +88,7 @@
>> >  #include <linux/bpf.h>
>> >  #include <linux/kernfs.h>
>> >  #include <linux/stringhash.h>  /* for hashlen_string() */
>> > +#include <uapi/linux/android/binder.h>
>> >  #include <uapi/linux/mount.h>
>> >  #include <linux/fsnotify.h>
>> >  #include <linux/fanotify.h>
>> > @@ -2029,7 +2030,8 @@ static int selinux_binder_transfer_binder(const =
struct cred *from,
>> >
>> >  static int selinux_binder_transfer_file(const struct cred *from,
>> >                                         const struct cred *to,
>> > -                                       struct file *file)
>> > +                                       struct file *file,
>> > +                                       u32 binder_object_flags)
>> >  {
>> >         u32 sid =3D cred_sid(to);
>> >         struct file_security_struct *fsec =3D selinux_file(file);
>> > @@ -2038,6 +2040,15 @@ static int selinux_binder_transfer_file(const s=
truct cred *from,
>> >         struct common_audit_data ad;
>> >         int rc;
>> >
>> > +       if (binder_object_flags & BINDER_FD_FLAG_XFER_CHARGE) {
>> > +               rc =3D avc_has_perm(&selinux_state,
>> > +                           cred_sid(from), sid,
>> > +                           SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
>> > +                           NULL);
>> > +               if (rc)
>> > +                       return rc;
>> > +       }
>> > +
>> >         ad.type =3D LSM_AUDIT_DATA_PATH;
>> >         ad.u.path =3D file->f_path;
>> >
>> > diff --git a/security/selinux/include/classmap.h b/security/selinux/in=
clude/classmap.h
>> > index a3c380775d41..2eef180d10d7 100644
>> > --- a/security/selinux/include/classmap.h
>> > +++ b/security/selinux/include/classmap.h
>> > @@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[]=
 =3D {
>> >         { "tun_socket",
>> >           { COMMON_SOCK_PERMS, "attach_queue", NULL } },
>> >         { "binder", { "impersonate", "call", "set_context_mgr", "trans=
fer",
>> > -                     NULL } },
>> > +                     "transfer_charge", NULL } },
>> >         { "cap_userns",
>> >           { COMMON_CAP_PERMS, NULL } },
>> >         { "cap2_userns",
>>
>> My first take on reading these changes above is that you've completely
>> ignored my previous comments about SELinux access controls around
>> resource management.  You've leveraged the existing LSM/SELinux hook
>> as we discussed previously, that's good, but can you explain what
>> changes you've made to address my concerns about one-off resource
>> management controls?
>>
> It's been a couple of weeks since v1 so I've sent this update out now to =
incorporate all the other feedback so far to make sure it's headed in the r=
ight direction. I've tried opening up a discussion about this rather unique=
 case, but there's been no activity on that yet.
>
Someone pointed out this didn't make it to the lists. Retrying.

>> --
>> paul-moore.com
