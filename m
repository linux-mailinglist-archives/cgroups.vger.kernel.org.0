Return-Path: <cgroups+bounces-14004-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPOGDcD/lWlHYAIAu9opvQ
	(envelope-from <cgroups+bounces-14004-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 19:06:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EBC15885E
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 19:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9233A30166DA
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733331280C;
	Wed, 18 Feb 2026 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhNMvWPu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F83C33064C
	for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438011; cv=pass; b=VdyG8IIaXPqoZZbT1ZyVE8/QS4q9Yu8JSIPhIMeI0OENqxQjLynFnx5YzCercJti58CL0r4/1C3gUsa53U4dTa4CqYMOikm70uL67uURKbI+fCRJ8WWL4/HuCIrhs+LKFiCTtaT0zg6tZCI9aphSBkVcLUVN3Y7jEx+thwSq8wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438011; c=relaxed/simple;
	bh=vKHFmimGHmcCxm1OfH95ndaDSr1nvlL1XXWRjG4Pjog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXYKlE7zOe8WbajBc7mfabaHjOtuEA06tn2Zng4S/+AuDE7Iki6XOpfF+Gj6bUKfU84ZvVVd0B6ulS/oAaWfmGUaznizYISOW/rZq1KcOrIrudJBJpOlQ4k4gDYDndM0f3TM7xsXfyODrq33i3lnGFH9ZcalPUiYhBzvq5jYEM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhNMvWPu; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48318d08ec2so2635e9.1
        for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 10:06:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771438008; cv=none;
        d=google.com; s=arc-20240605;
        b=UZ+leWHFqvVtFwxRhm7+9CuaIlnbBuxp6n3439371ZHC3GRdsB5COHtTtIUzWRTFdC
         BW7YYC6Binn/39OIPEz9KtvNd6LRY3HBmI9RyZ65IOx78tLxf09TNHSreSNnDjXiMnGY
         tVFrtTJ9zXZhQLYF7ts1nCblXk8mn91Tw3CltDio01vmdHTbX3FBKhxw0fgk1cYUN0Qz
         +1Bu985v3i9yVZK0m8rJOJBKLLPWx9fLwpjPoNDhJx2rQ/gAiQKWwhGI4S99b0ZXkYSu
         ikd56JOp+a8c5r3NEUSdw+jdScjYLsvDpc28q4p/tf6ve4hIXqoCSKKn0J5HfBcjQgG7
         /CaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1f95vZTOi5Yw4hvqLUrqCnxMotQccaY9rSWPiX8Mka0=;
        fh=wuhsRHJ9icRr9lRoyEeoNvil7tk1KjDGz7KYk7DmQLo=;
        b=X8IWvt73m1SDgZ2KKocdX1aEvS1ZfXDCDk6aY2PGaoazCmLg+ZStLfd1iX0xog6urC
         bNIxwEfulh9R05oZr3cBpRKEYgs0/95JcveWLKis6apdSS1l1Ka+oslwAUg53TnFmmBm
         My/q0Wd05xlLzvdA5jMLS2BkNARmHMc/vF/UtzFruFkx+BFUY3vJCWOTi9fyfmzqbddt
         MgzMzBSgRghHkH3VXCQi3Uxq3D3UGXXejR40sWNqXi5AlaO3EaWRVPyJ6v54pSz63ss2
         zKTZbJZMtGJojlCf29QmWdsOhXN+Y5sIJ0ZLW72+XSOn/yS/CrhIXfNN+pUhxpz0Php6
         vcTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771438008; x=1772042808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1f95vZTOi5Yw4hvqLUrqCnxMotQccaY9rSWPiX8Mka0=;
        b=qhNMvWPuim6JSMCm/6+TDOIpVik3k9+UUa4+JiVqMFIs+Z9jciAUwNCqvCMF6n4Xz2
         3U0f5uMEyKv4hUPb6WgN+UmjTc+2HrMtNQI/s6qkEButK9BKHqeyeIpKIwd2Ee1E+U8d
         GTVy3P2/Gooqh7ql10PcIzBjdf0VxH2Tgrltv/BO6CbIJjZm9vHGXH6YwDwMaAxKopbs
         fG+yU5Cj5BzLSEVCStSjhvKuESb4S4RvbjcMIBuZsTKT6MxA1pJXg3hihCzpgUK2ssWL
         IgLrCbn8b1WZ2spWQl5OjU7uuxLFL7BCbnRrQu685gQ7Veq3NGUUe1FFQkW1u6SvnA7m
         qBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771438008; x=1772042808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1f95vZTOi5Yw4hvqLUrqCnxMotQccaY9rSWPiX8Mka0=;
        b=YiYYHFuhauVomyXyd/BmWpTX9is5KkzO1OvUq+51vm/fduQ6CbwJnu2cPns6EwHrnj
         5+gV8ojPl05JJuSp2vbozKbYvfaUoXRmFk1/1BM+Tkejym8mgGLXPyw4T4u77V9iahb5
         kIvBRAOP6/XfohJhOfEyzFzi3jzijG/xMGZDblCtECsAtYl73SMij1j83whJOtgO/pmm
         LD3zTfHY5pnpjQ7pmp0XBMkNyw6trZAkl/OBu9fZAVQ7d3w4DAcTVWkVySrggvz3kTwM
         zsyO4K9feU7CKFt6gsF4WVeSozI37Q9y05+MkjiC145mDZldwMNK2etAXkUjgxKWUNNx
         DsZw==
X-Forwarded-Encrypted: i=1; AJvYcCX2vQaC512d4mHKKEUnYfaUIelv64yH9z0GZ9azrmTKA8BZYKe/8LGieGlZ4msAH2y9fRBYF6D1@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUF4mYSgVlr5+sTAVdcbURGAVfScjSq+DlQOM9OL3jL6/52dg
	pm6kBfP/9EaWXjJJtL7M1quHwxJdf3Zb62Ggc6Krt8lT4F6J8lEx9i3Upkt0dtJNxLf9/r1yYHy
	cxyOaNn+Z7frLbbgWg+AQ8M82oxV3O8jnFQTw7vRI
X-Gm-Gg: AZuq6aKgCJjjrvBqo11mSSNKwP+yPeJobAzbrKr6SGGElwYk9TVHic7GsSQdUpiFIdt
	dXrR48n1+kX7IIGLdSrm8G+ddFcM58zccZja5C8OMrxqB/hDzk+sZ/CtivDQm2bv5PcUkwtz7zX
	WU2bPH+sRREnv7oY7pQDqKyWRsdJVPvofjysPM9UhhFPZKD0bRU1NDMAlGwe9DnS7ajSKbJHzjl
	xfdydCMaS/SabbL1x6bjCGZPgBoTFkpvcwDQ2CIBA/ZA8/u5gGdlCo2Jy4D1P7KGF3Epjkb1bHu
	bnJNFq2OvfcYZcfelxJlCMrYLyGRdF8BxfiMsqdRLwkJrhaJl3g0Ln7tA1aC4vhEKK3cWA==
X-Received: by 2002:a05:600c:5251:b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-4839e5d968cmr18215e9.2.1771438007529; Wed, 18 Feb 2026 10:06:47
 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com> <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
In-Reply-To: <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 18 Feb 2026 10:06:35 -0800
X-Gm-Features: AaiRm53thvlVisx2lMRMuScTFsLjEYaxzAzammhyQCf8yauixPxpvKuRWHvq3fQ
Message-ID: <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
To: Jan Kara <jack@suse.cz>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14004-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[memory.events:url,suse.cz:email,mail.gmail.com:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1EBC15885E
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:01=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > Currently some kernfs files (e.g. cgroup.events, memory.events) support
> > inotify watches for IN_MODIFY, but unlike with regular filesystems, the=
y
> > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > removed.
>
> Please see my email:
> https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4zvxylx73=
2voet@ol3kl4ackrpb
>
> I think this is actually a bug in kernfs...
>
>                                                                 Honza

Thanks, I'm looking at this now. I've tried calling clear_nlink in
kernfs_iop_rmdir, but I've found that when we get back to vfs_rmdir
and shrink_dcache_parent is called, d_walk doesn't find any entries,
so shrink_kill->__dentry_kill is not called. I'm investigating why
that is...

> >
> > This creates a problem for processes monitoring cgroups. For example, a
> > service monitoring memory.events for memory.high breaches needs to know
> > when a cgroup is removed to clean up its state. Where it's known that a
> > cgroup is removed when all processes die, without IN_DELETE_SELF the
> > service must resort to inefficient workarounds such as:
> > 1.  Periodically scanning procfs to detect process death (wastes CPU an=
d
> >     is susceptible to PID reuse).
> > 2.  Placing an additional IN_DELETE watch on the parent directory
> >     (wastes resources managing double the watches).
> > 3.  Holding a pidfd for every monitored cgroup (can exhaust file
> >     descriptors).
> >
> > This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED events.
> > This allows applications to rely on a single existing watch on the file
> > of interest (e.g. memory.events) to receive notifications for both
> > modifications and the eventual removal of the file, as well as automati=
c
> > watch descriptor cleanup, simplifying userspace logic and improving
> > resource efficiency.
> >
> > Implementation details:
> > The kernfs notification worker is updated to handle file deletion.
> > The optimized single call for MODIFY events to both the parent and the
> > file is retained, however because CREATE (parent) events remain
> > unsupported for kernfs files, support for DELETE (parent) events is not
> > added here to retain symmetry. Only support for DELETE_SELF events is
> > added.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > ---
> >  fs/kernfs/dir.c             | 21 +++++++++++++++++
> >  fs/kernfs/file.c            | 45 ++++++++++++++++++++-----------------
> >  fs/kernfs/kernfs-internal.h |  3 +++
> >  3 files changed, 48 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 29baeeb97871..e5bda829fcb8 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/sched.h>
> >  #include <linux/fs.h>
> > +#include <linux/fsnotify_backend.h>
> >  #include <linux/namei.h>
> >  #include <linux/idr.h>
> >  #include <linux/slab.h>
> > @@ -1471,6 +1472,23 @@ void kernfs_show(struct kernfs_node *kn, bool sh=
ow)
> >       up_write(&root->kernfs_rwsem);
> >  }
> >
> > +static void kernfs_notify_file_deleted(struct kernfs_node *kn)
> > +{
> > +     static DECLARE_WORK(kernfs_notify_deleted_work,
> > +                         kernfs_notify_workfn);
> > +
> > +     guard(spinlock_irqsave)(&kernfs_notify_lock);
> > +     /* may overwite already pending FS_MODIFY events */
> > +     kn->attr.notify_event =3D FS_DELETE;
> > +
> > +     if (!kn->attr.notify_next) {
> > +             kernfs_get(kn);
> > +             kn->attr.notify_next =3D kernfs_notify_list;
> > +             kernfs_notify_list =3D kn;
> > +             schedule_work(&kernfs_notify_deleted_work);
> > +     }
> > +}
> > +
> >  static void __kernfs_remove(struct kernfs_node *kn)
> >  {
> >       struct kernfs_node *pos, *parent;
> > @@ -1520,6 +1538,9 @@ static void __kernfs_remove(struct kernfs_node *k=
n)
> >                       struct kernfs_iattrs *ps_iattr =3D
> >                               parent ? parent->iattr : NULL;
> >
> > +                     if (kernfs_type(pos) =3D=3D KERNFS_FILE)
> > +                             kernfs_notify_file_deleted(pos);
> > +
> >                       /* update timestamps on the parent */
> >                       down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
> >
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index e978284ff983..4be9bbe29378 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -37,8 +37,8 @@ struct kernfs_open_node {
> >   */
> >  #define KERNFS_NOTIFY_EOL                    ((void *)&kernfs_notify_l=
ist)
> >
> > -static DEFINE_SPINLOCK(kernfs_notify_lock);
> > -static struct kernfs_node *kernfs_notify_list =3D KERNFS_NOTIFY_EOL;
> > +DEFINE_SPINLOCK(kernfs_notify_lock);
> > +struct kernfs_node *kernfs_notify_list =3D KERNFS_NOTIFY_EOL;
> >
> >  static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_n=
ode *kn)
> >  {
> > @@ -909,7 +909,7 @@ static loff_t kernfs_fop_llseek(struct file *file, =
loff_t offset, int whence)
> >       return ret;
> >  }
> >
> > -static void kernfs_notify_workfn(struct work_struct *work)
> > +void kernfs_notify_workfn(struct work_struct *work)
> >  {
> >       struct kernfs_node *kn;
> >       struct kernfs_super_info *info;
> > @@ -935,11 +935,7 @@ static void kernfs_notify_workfn(struct work_struc=
t *work)
> >       down_read(&root->kernfs_supers_rwsem);
> >       down_read(&root->kernfs_rwsem);
> >       list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
> > -             struct kernfs_node *parent;
> > -             struct inode *p_inode =3D NULL;
> > -             const char *kn_name;
> >               struct inode *inode;
> > -             struct qstr name;
> >
> >               /*
> >                * We want fsnotify_modify() on @kn but as the
> > @@ -951,24 +947,31 @@ static void kernfs_notify_workfn(struct work_stru=
ct *work)
> >               if (!inode)
> >                       continue;
> >
> > -             kn_name =3D kernfs_rcu_name(kn);
> > -             name =3D QSTR(kn_name);
> > -             parent =3D kernfs_get_parent(kn);
> > -             if (parent) {
> > -                     p_inode =3D ilookup(info->sb, kernfs_ino(parent))=
;
> > -                     if (p_inode) {
> > -                             fsnotify(notify_event | FS_EVENT_ON_CHILD=
,
> > -                                      inode, FSNOTIFY_EVENT_INODE,
> > -                                      p_inode, &name, inode, 0);
> > -                             iput(p_inode);
> > +             if (notify_event =3D=3D FS_DELETE) {
> > +                     fsnotify_inoderemove(inode);
> > +             } else {
> > +                     struct kernfs_node *parent =3D kernfs_get_parent(=
kn);
> > +                     struct inode *p_inode =3D NULL;
> > +
> > +                     if (parent) {
> > +                             p_inode =3D ilookup(info->sb, kernfs_ino(=
parent));
> > +                             if (p_inode) {
> > +                                     const char *kn_name =3D kernfs_rc=
u_name(kn);
> > +                                     struct qstr name =3D QSTR(kn_name=
);
> > +
> > +                                     fsnotify(notify_event | FS_EVENT_=
ON_CHILD,
> > +                                              inode, FSNOTIFY_EVENT_IN=
ODE,
> > +                                              p_inode, &name, inode, 0=
);
> > +                                     iput(p_inode);
> > +                             }
> > +
> > +                             kernfs_put(parent);
> >                       }
> >
> > -                     kernfs_put(parent);
> > +                     if (!p_inode)
> > +                             fsnotify_inode(inode, notify_event);
> >               }
> >
> > -             if (!p_inode)
> > -                     fsnotify_inode(inode, notify_event);
> > -
> >               iput(inode);
> >       }
> >
> > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> > index 6061b6f70d2a..cf4b21f4f3b6 100644
> > --- a/fs/kernfs/kernfs-internal.h
> > +++ b/fs/kernfs/kernfs-internal.h
> > @@ -199,6 +199,8 @@ struct kernfs_node *kernfs_new_node(struct kernfs_n=
ode *parent,
> >   * file.c
> >   */
> >  extern const struct file_operations kernfs_file_fops;
> > +extern struct kernfs_node *kernfs_notify_list;
> > +extern void kernfs_notify_workfn(struct work_struct *work);
> >
> >  bool kernfs_should_drain_open_files(struct kernfs_node *kn);
> >  void kernfs_drain_open_files(struct kernfs_node *kn);
> > @@ -212,4 +214,5 @@ extern const struct inode_operations kernfs_symlink=
_iops;
> >   * kernfs locks
> >   */
> >  extern struct kernfs_global_locks *kernfs_locks;
> > +extern spinlock_t kernfs_notify_lock;
> >  #endif       /* __KERNFS_INTERNAL_H */
> > --
> > 2.53.0.310.g728cabbaf7-goog
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

