Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE911D97E4
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2020 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgESNgf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 May 2020 09:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgESNge (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 May 2020 09:36:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E7AC08C5C0;
        Tue, 19 May 2020 06:36:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so3632882wmd.0;
        Tue, 19 May 2020 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zNreZvu7yPIbC0bjOLvwAbJKHUIq0ZvwlK54VNbHmBg=;
        b=sSLBF0PlF4F/nulo1Uxz+T7/djxX0FdfivWIUTYJrDs/9DYHguFU2zVyp7llPM0g+2
         /SwtKjk328iChWsvzi4PKoHEfkRnU6VDqoeXOQJ26ltYziArC+l3NA/f97mZuteXNfHP
         fjkLW/Rkq3DAqNJDrKt8PUXb/13CYxj0fg/92iSlkCtEO0sJjy48HtnOG5UKTxPEExER
         Hy4ShqxvRmSqLbpk3wBr/jxSdUBEWHJj0wHswhcS3UCqL4auogSZIbQNexVlNRBW+rGu
         F2X+1ow+vUrtXKgJZETDyQOKHDjPi926IgenqFCyyNRZ4sSfS7l9d4FJYIGqvxtVgQ9A
         R3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zNreZvu7yPIbC0bjOLvwAbJKHUIq0ZvwlK54VNbHmBg=;
        b=bsQEnu+3LhvJMra4dtzLGeC+eige6bffjOg6gGuQoaNqigVkMPM/zYobzqiY4h+0pg
         yPHjn4vRTN0ph19EmypkHuyTaPBUZYYAHVIahO2Kpb3cIk5nWGKqCxIDFr5AYTZbF9uv
         tX0M5Q80qNVF5k1Vhyyi4ZGqdqpHcExzSxW2KVjW+ld6nkcNNUxF09Wk8EJCKLFxkqvk
         sbyz261bzOZ5HRmrgemm4K39wWEtn3zzgNtu6Zm5qGAf2BkxbrtPU/7hYd8q/O/39MN9
         c/suVjjEE9r4whLTf79fpkGV54yJRCfQ/BQZu5PNKskyH08NUCkKLkWkVEoCDgfMMZA7
         P4+Q==
X-Gm-Message-State: AOAM533ABnjpnYiYcdp5KWNDdJe7P5WkYAdEgu4tghUgpYB4FyfKodYI
        Zx92YyiJApNULi8+UjBnwwo=
X-Google-Smtp-Source: ABdhPJyhJB7g+shXTTJ0kl/BlTznTQAX0YpEyZ4VsOWGAxtXzWjSTIgS73iztljcEx/VZ3Ym8Ql7uQ==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr5737543wmb.85.1589895392015;
        Tue, 19 May 2020 06:36:32 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id r14sm4487413wmb.2.2020.05.19.06.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 06:36:31 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, cgroups@vger.kernel.org,
        christian.brauner@ubuntu.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        oleg@redhat.com, tj@kernel.org
Subject: Re: [PATCH v2] clone.2: Document CLONE_INTO_CGROUP
To:     Christian Brauner <christian@brauner.io>
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
 <20200518175549.3400948-1-christian@brauner.io>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <25b2d051-d276-d570-5608-2bf0f4f46ef1@gmail.com>
Date:   Tue, 19 May 2020 15:36:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518175549.3400948-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Christian,

Thanks for this patch!

On 5/18/20 7:55 PM, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> - Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>:
>   - Fix various types and add examples and how to specify the file
>     descriptor.
> ---
>  man2/clone.2 | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/man2/clone.2 b/man2/clone.2
> index 8b70b78a4..33594ddc5 100644
> --- a/man2/clone.2
> +++ b/man2/clone.2
> @@ -197,6 +197,7 @@ struct clone_args {
>      u64 tls;          /* Location of new TLS */
>      u64 set_tid;      /* Pointer to a \fIpid_t\fP array */
>      u64 set_tid_size; /* Number of elements in \fIset_tid\fP */
> +    u64 cgroup;       /* Target cgroup file descriptor for the child process */
>  };
>  .EE
>  .in
> @@ -448,6 +449,48 @@ Specifying this flag together with
>  .B CLONE_SIGHAND
>  is nonsensical and disallowed.
>  .TP
> +.BR CLONE_INTO_CGROUP " (since Linux 5.7)"
> +.\" commit ef2c41cf38a7559bbf91af42d5b6a4429db8fc68
> +By default, the child process will be placed in the same version 2
> +cgroup as its parent.
> +If this flag is specified the child process will be created in a
> +different cgroup than its parent.
> +Note, that
> +.BR CLONE_INTO_CGROUP
> +is limited to version 2 cgroups. To use this feature, callers
> +need to raise
> +.BR CLONE_INTO_CGROUP
> +in
> +.I cl_args.flags
> +and pass a directory file descriptor (see the
> +.BR O_DIRECTORY
> +flag for the
> +.BR open (2)
> +syscall) in the

I think the mention of O_DIRECTORY here is a bit misleading. That
flag does not need to be used. O_RDONLY or O_PATH suffices; I 
reworded somewhat.

> +.I cl_args.cgroup.
> +The caller may also pass an
> +.BR O_PATH
> +(see
> +.BR open (2))
> +file descriptor for the target cgroup.
> +Note, that all usual version 2 cgroup migration restrictions (see
> +.BR cgroups (7)
> +for details) apply.

Here I presume you mean things like the "no internal processes 
rule" and the restriction around putting a process into a
"domain invalid" cgroup, right? I reworded a things and added
a couple of cases in ERRORS.

> +
> +Spawning a process into a cgroup different from the parent's cgroup
> +makes it possible for a service manager to directly spawn new
> +services into dedicated cgroups. This allows eliminating accounting
> +jitter which would be caused by the new process living in the
> +parent's cgroup for a short amount of time before being
> +moved into the target cgroup. This flag also allows the creation of
> +frozen child process by spawning them into a frozen cgroup (see
> +.BR cgroups (7)
> +for a description of the freezer feature in version 2 cgroups).
> +For threaded applications or even thread implementations which
> +make use of cgroups to limit individual threads it is possible to
> +establish a fixed cgroup layout before spawning each thread
> +directly into its target cgroup.

Thanks for these use cases; that's great!

So, I did some fairly heavy editing, which resulted in the
following (the sum of the diffs is shown at the end of this
mail):

       CLONE_INTO_CGROUP (since Linux 5.7)
              By default, a child process is placed in the same version 2
              cgroup  as  its  parent.   The CLONE_INTO_CGROUP allows the
              child process to  be  created  in  a  different  version  2
              cgroup.   (Note  that CLONE_INTO_CGROUP has effect only for
              version 2 cgroups.)

              In order to place the child process in a different  cgroup,
              the caller specifies CLONE_INTO_CGROUP in cl_args.flags and
              passes a file descriptor that refers to a version 2  cgroup
              in  the cl_args.cgroup field.  (This file descriptor can be
              obtained by opening a cgroup v2 directory file using either
              the  O_RDONLY  or  the  O_PATH flag.)  Note that all of the
              usual restrictions (described in cgroups(7)) on  placing  a
              process into a version 2 cgroup apply.

              Spawning  a  process  into a cgroup different from the par‐
              ent's cgroup makes it possible for  a  service  manager  to
              directly  spawn  new services into dedicated cgroups.  This
              eliminates the accounting jitter that would  be  caused  if
              the  child  process was first created in the same cgroup as
              the parent and then moved  into  the  target  cgroup.   The
              CLONE_INTO_CGROUP  flag  also allows the creation of frozen
              child processes by spawning  them  into  a  frozen  cgroup.
              (See  cgroups(7)  for  a  description  of  the freezer con‐
              troller.)  For threaded applications (or even thread imple‐
              mentations  which  make  use of cgroups to limit individual
              threads), it is possible to establish a fixed cgroup layout
              before  spawning  each  thread  directly  into  its  target
              cgroup.

ERRORS
       EBUSY (clone3() only)
              CLONE_INTO_CGROUP  was  specified in cl_args.flags, but the
              file descriptor specified in  cl_args.cgroup  refers  to  a
              version 2 cgroup in which a domain controller is enabled.

       EOPNOTSUP (clone3() only)
              CLONE_INTO_CGROUP  was  specified in cl_args.flags, but the
              file descriptor specified in  cl_args.cgroup  refers  to  a
              version 2 cgroup that is in the domain invalid state.

Look okay to you?

Thanks,

Michael


diff --git a/man2/clone.2 b/man2/clone.2
index 8b70b78a4..a4ce0d412 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -195,8 +195,12 @@ struct clone_args {
     u64 stack;        /* Pointer to lowest byte of stack */
     u64 stack_size;   /* Size of stack */
     u64 tls;          /* Location of new TLS */
-    u64 set_tid;      /* Pointer to a \fIpid_t\fP array */
-    u64 set_tid_size; /* Number of elements in \fIset_tid\fP */
+    u64 set_tid;      /* Pointer to a \fIpid_t\fP array
+                         (since Linux 5.5) */
+    u64 set_tid_size; /* Number of elements in \fIset_tid\fP
+                         (since Linux 5.5) */
+    u64 cgroup;       /* File descriptor for target cgroup
+                         of child (since Linux 5.7) */
 };
 .EE
 .in
@@ -266,6 +270,7 @@ stack	stack
 tls	tls	See CLONE_SETTLS
 \fP---\fP	set_tid	See below for details
 \fP---\fP	set_tid_size
+\fP---\fP	cgroup	See CLONE_INTO_CGROUP
 .TE
 .RE
 .\"
@@ -448,6 +453,54 @@ Specifying this flag together with
 .B CLONE_SIGHAND
 is nonsensical and disallowed.
 .TP
+.BR CLONE_INTO_CGROUP " (since Linux 5.7)"
+.\" commit ef2c41cf38a7559bbf91af42d5b6a4429db8fc68
+By default, a child process is placed in the same version 2
+cgroup as its parent.
+The
+.B CLONE_INTO_CGROUP
+allows the child process to be created in a different version 2 cgroup.
+(Note that
+.BR CLONE_INTO_CGROUP
+has effect only for version 2 cgroups.)
+.IP
+In order to place the child process in a different cgroup,
+the caller specifies
+.BR CLONE_INTO_CGROUP
+in
+.I cl_args.flags
+and passes a file descriptor that refers to a version 2 cgroup in the
+.I cl_args.cgroup
+field.
+(This file descriptor can be obtained by opening a cgroup v2 directory file
+using either the
+.B O_RDONLY
+or the
+.B O_PATH
+flag.)
+Note that all of the usual restrictions (described in
+.BR cgroups (7))
+on placing a process into a version 2 cgroup apply.
+.IP
+Spawning a process into a cgroup different from the parent's cgroup
+makes it possible for a service manager to directly spawn new
+services into dedicated cgroups.
+This eliminates the accounting
+jitter that would be caused if the child process was first created in the
+same cgroup as the parent and then
+moved into the target cgroup.
+The
+.BR CLONE_INTO_CGROUP
+flag also allows the creation of
+frozen child processes by spawning them into a frozen cgroup.
+(See
+.BR cgroups (7)
+for a description of the freezer controller.)
+For threaded applications (or even thread implementations which
+make use of cgroups to limit individual threads), it is possible to
+establish a fixed cgroup layout before spawning each thread
+directly into its target cgroup.
+.TP
 .BR CLONE_DETACHED " (historical)"
 For a while (during the Linux 2.5 development series)
 .\" added in 2.5.32; removed in 2.6.0-test4
@@ -1304,6 +1357,14 @@ will be set appropriately.
 Too many processes are already running; see
 .BR fork (2).
 .TP
+.BR EBUSY " (" clone3 "() only)"
+.B CLONE_INTO_CGROUP
+was specified in
+.IR cl_args.flags ,
+but the file descriptor specified in
+.IR cl_args.cgroup
+refers to a version 2 cgroup in which a domain controller is enabled.
+.TP
 .BR EEXIST " (" clone3 "() only)"
 One (or more) of the PIDs specified in
 .I set_tid
@@ -1546,6 +1607,16 @@ to be exceeded.
 For further details, see
 .BR namespaces (7).
 .TP
+.BR EOPNOTSUP " (" clone3 "() only)"
+.B CLONE_INTO_CGROUP
+was specified in
+.IR cl_args.flags ,
+but the file descriptor specified in
+.IR cl_args.cgroup
+refers to a version 2 cgroup that is in the
+.IR "domain invalid"
+state.
+.TP
 .B EPERM
 .BR CLONE_NEWCGROUP ,
 .BR CLONE_NEWIPC ,



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
