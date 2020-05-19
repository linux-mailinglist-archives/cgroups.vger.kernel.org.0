Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC55D1D9892
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2020 15:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgESNv3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 May 2020 09:51:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48337 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgESNv2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 May 2020 09:51:28 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jb2eT-0003VK-D6; Tue, 19 May 2020 13:51:25 +0000
Date:   Tue, 19 May 2020 15:51:24 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>, cgroups@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, oleg@redhat.com, tj@kernel.org
Subject: Re: [PATCH v2] clone.2: Document CLONE_INTO_CGROUP
Message-ID: <20200519135124.xhgdeaogmvmwbofc@wittgenstein>
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
 <20200518175549.3400948-1-christian@brauner.io>
 <25b2d051-d276-d570-5608-2bf0f4f46ef1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25b2d051-d276-d570-5608-2bf0f4f46ef1@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 19, 2020 at 03:36:28PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Christian,
> 
> Thanks for this patch!

Thanks for making it palatable. :)

> 
> On 5/18/20 7:55 PM, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v2 */
> > - Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>:
> >   - Fix various types and add examples and how to specify the file
> >     descriptor.
> > ---
> >  man2/clone.2 | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/man2/clone.2 b/man2/clone.2
> > index 8b70b78a4..33594ddc5 100644
> > --- a/man2/clone.2
> > +++ b/man2/clone.2
> > @@ -197,6 +197,7 @@ struct clone_args {
> >      u64 tls;          /* Location of new TLS */
> >      u64 set_tid;      /* Pointer to a \fIpid_t\fP array */
> >      u64 set_tid_size; /* Number of elements in \fIset_tid\fP */
> > +    u64 cgroup;       /* Target cgroup file descriptor for the child process */
> >  };
> >  .EE
> >  .in
> > @@ -448,6 +449,48 @@ Specifying this flag together with
> >  .B CLONE_SIGHAND
> >  is nonsensical and disallowed.
> >  .TP
> > +.BR CLONE_INTO_CGROUP " (since Linux 5.7)"
> > +.\" commit ef2c41cf38a7559bbf91af42d5b6a4429db8fc68
> > +By default, the child process will be placed in the same version 2
> > +cgroup as its parent.
> > +If this flag is specified the child process will be created in a
> > +different cgroup than its parent.
> > +Note, that
> > +.BR CLONE_INTO_CGROUP
> > +is limited to version 2 cgroups. To use this feature, callers
> > +need to raise
> > +.BR CLONE_INTO_CGROUP
> > +in
> > +.I cl_args.flags
> > +and pass a directory file descriptor (see the
> > +.BR O_DIRECTORY
> > +flag for the
> > +.BR open (2)
> > +syscall) in the
> 
> I think the mention of O_DIRECTORY here is a bit misleading. That
> flag does not need to be used. O_RDONLY or O_PATH suffices; I 
> reworded somewhat.
> 
> > +.I cl_args.cgroup.
> > +The caller may also pass an
> > +.BR O_PATH
> > +(see
> > +.BR open (2))
> > +file descriptor for the target cgroup.
> > +Note, that all usual version 2 cgroup migration restrictions (see
> > +.BR cgroups (7)
> > +for details) apply.
> 
> Here I presume you mean things like the "no internal processes 
> rule" and the restriction around putting a process into a
> "domain invalid" cgroup, right? I reworded a things and added
> a couple of cases in ERRORS.
> 
> > +
> > +Spawning a process into a cgroup different from the parent's cgroup
> > +makes it possible for a service manager to directly spawn new
> > +services into dedicated cgroups. This allows eliminating accounting
> > +jitter which would be caused by the new process living in the
> > +parent's cgroup for a short amount of time before being
> > +moved into the target cgroup. This flag also allows the creation of
> > +frozen child process by spawning them into a frozen cgroup (see
> > +.BR cgroups (7)
> > +for a description of the freezer feature in version 2 cgroups).
> > +For threaded applications or even thread implementations which
> > +make use of cgroups to limit individual threads it is possible to
> > +establish a fixed cgroup layout before spawning each thread
> > +directly into its target cgroup.
> 
> Thanks for these use cases; that's great!
> 
> So, I did some fairly heavy editing, which resulted in the
> following (the sum of the diffs is shown at the end of this
> mail):
> 
>        CLONE_INTO_CGROUP (since Linux 5.7)
>               By default, a child process is placed in the same version 2
>               cgroup  as  its  parent.   The CLONE_INTO_CGROUP allows the

Not a native speaker, but is this missing a noun like "flag"?
"The CLONE_INTO_CGROUP {flag,feature} allows the [...]"?

>               child process to  be  created  in  a  different  version  2
>               cgroup.   (Note  that CLONE_INTO_CGROUP has effect only for
>               version 2 cgroups.)
> 
>               In order to place the child process in a different  cgroup,
>               the caller specifies CLONE_INTO_CGROUP in cl_args.flags and
>               passes a file descriptor that refers to a version 2  cgroup
>               in  the cl_args.cgroup field.  (This file descriptor can be
>               obtained by opening a cgroup v2 directory file using either

Should this just be "opening a cgroup v2 directory" and not "directory
file"? Feels redundant.

>               the  O_RDONLY  or  the  O_PATH flag.)  Note that all of the
>               usual restrictions (described in cgroups(7)) on  placing  a
>               process into a version 2 cgroup apply.
> 
>               Spawning  a  process  into a cgroup different from the par‐
>               ent's cgroup makes it possible for  a  service  manager  to
>               directly  spawn  new services into dedicated cgroups.  This
>               eliminates the accounting jitter that would  be  caused  if
>               the  child  process was first created in the same cgroup as
>               the parent and then moved  into  the  target  cgroup.   The

I forgot to mention that spawning directly into a target cgroup is also
more efficient than moving it after creation. The specific reason is
mentioned in the commit message, the write lock of the semaphore need
not be taken in contrast to when it is moved afterwards. That
implementation details is not that interesting but it might be
interesting to know that it provides performance benefits in general.

>               CLONE_INTO_CGROUP  flag  also allows the creation of frozen
>               child processes by spawning  them  into  a  frozen  cgroup.
>               (See  cgroups(7)  for  a  description  of  the freezer con‐
>               troller.)  For threaded applications (or even thread imple‐
>               mentations  which  make  use of cgroups to limit individual
>               threads), it is possible to establish a fixed cgroup layout
>               before  spawning  each  thread  directly  into  its  target
>               cgroup.
> 
> ERRORS
>        EBUSY (clone3() only)
>               CLONE_INTO_CGROUP  was  specified in cl_args.flags, but the
>               file descriptor specified in  cl_args.cgroup  refers  to  a
>               version 2 cgroup in which a domain controller is enabled.
> 
>        EOPNOTSUP (clone3() only)
>               CLONE_INTO_CGROUP  was  specified in cl_args.flags, but the
>               file descriptor specified in  cl_args.cgroup  refers  to  a
>               version 2 cgroup that is in the domain invalid state.

Ah, good catch with the errnos.

> 
> Look okay to you?

Yep, looks great!
Thanks!
Christian
