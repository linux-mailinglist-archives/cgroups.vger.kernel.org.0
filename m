Return-Path: <cgroups+bounces-6202-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE7A140E9
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 18:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA30F7A2E8C
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01171DED44;
	Thu, 16 Jan 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzjynfUR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACFE14B094;
	Thu, 16 Jan 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048730; cv=none; b=dP3AC9+aMydCNjfW2UFuku+bdpHLdWsrLQIBL/5Gis6Z8c/xmMKAlY/JnB4lfi9AyoyEj7Wsraw/8LFcF77QYt6CUxn1tcrVR9CsG46K3Jupq/GnCDJqkrPX+afBIjEYTxq4hUb8LarjxdBHVkVDC4j+By7DcptY1/Ax2njVb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048730; c=relaxed/simple;
	bh=/WeFkx4/uThtV6LlI/STrLsUIBCZGXe6zO0jvy8kMM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qotdUySqBZejC20gS9EXhTzaBEigXpVplTntdturj4C2vPixkgmVBtcFrlDwHFAQvP8frW7fLGECz1MKsSgFKAbte1QpB0NPU90oCACN7iJMshXJN7x2VZUjsKYUJUy42Qp8qg+CVIvzn5BbgoLGeZzh/XUPArc3oEGJZLQQiH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzjynfUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1883C4CED6;
	Thu, 16 Jan 2025 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737048729;
	bh=/WeFkx4/uThtV6LlI/STrLsUIBCZGXe6zO0jvy8kMM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzjynfUR+XW+CI3c/u443L9bcnTn60IF1GH0FQUHAwxeGeBjaDkd/kxylHTwvlrD+
	 uOlCr/FvXdboC/ZVxFeHoAcUaO5EmTvUom7lh3GCrx9bAQIGHm23iazBKZydMaBHYu
	 haFaxW3uKcvSjEamnDbl0qq6i4Pk0zdWm/fOfHdM0Mj9+29V9Vg5xNtKyEN/lcUYOf
	 DbQj64FeTUPKNLknNsXMQfeYFuT2U6ZlLmjjAQY36dyBSk5g1la5FjCGkrleL8E9YZ
	 gwHsQBAuGkLdZVB/YLQ+pZHggH9zjo8r9qGg+27jtGkpsRUUSrgSsTFqydrq7UWyTK
	 mZ+23cBhDczdQ==
Date: Thu, 16 Jan 2025 07:32:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] kernfs: Use RCU for kernfs_node::name and ::parent
 lookup.
Message-ID: <Z4lCmIB_7cPm0Ebv@slm.duckdns.org>
References: <20241121175250.EJbI7VMb@linutronix.de>
 <Z0-Eg0B09JQUZG2N@slm.duckdns.org>
 <20250116132745.dU941oor@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116132745.dU941oor@linutronix.de>

Hello,

On Thu, Jan 16, 2025 at 02:27:45PM +0100, Sebastian Andrzej Siewior wrote:
> > Shouldn't this be freed somewhere?
> 
> There is
>          char *kn_name __free(kfree) = NULL;
> 
> at the top. This will kfree(kn_name) once it is out of scope (on return
> from rdtgroup_pseudo_lock_create()).

Ah, makes sense.

...
> > > @@ -557,16 +568,18 @@ void kernfs_put(struct kernfs_node *kn)
> > >  	if (!kn || !atomic_dec_and_test(&kn->count))
> > >  		return;
> > >  	root = kernfs_root(kn);
> > > +	guard(rcu)();
> > >   repeat:
> > >  	/*
> > >  	 * Moving/renaming is always done while holding reference.
> > >  	 * kn->parent won't change beneath us.
> > >  	 */
> > > -	parent = kn->parent;
> > > +	parent = rcu_dereference(kn->parent);
> > 
> > I wonder whether it'd be better to encode the reference count rule (ie. add
> > the condition kn->count == 0 to deref_check) in the kn->parent deref
> > accessor. This function doesn't need RCU read lock and holding it makes it
> > more confusing.
> 
> You are saying that we don't need RCU here because if we drop the last
> reference then nobody can rename the node anymore and so parent can't
> change. That sounds right.
> What about using rcu_dereference_protected() instead? Using
> rcu_dereference(x, !atomic_read(&kn->count)) looks odd given that we
> established that the counter is 0. Therefore I would suggest
> rcu_access_pointer() but the reference drop might qualify as "locked".

I think it's usually a better form to encode the whole access rule in a
shared accessor for the field so that the deref rules for the field can be
understood and enforced from the shared accessor and the shared accessor
would use rcu_dereference_protected() internally.

> > > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > > index 8502ef68459b9..05f7b30283150 100644
> > > --- a/fs/kernfs/file.c
> > > +++ b/fs/kernfs/file.c
> > > @@ -911,9 +911,11 @@ static void kernfs_notify_workfn(struct work_struct *work)
> > >  	/* kick fsnotify */
> > >  
> > >  	down_read(&root->kernfs_supers_rwsem);
> > > +	down_read(&root->kernfs_rwsem);
> > 
> > Why is this addition necessary? Hmm... was the code previously broken w.r.t.
> > renaming? Can this be RCU?
> 
> I *think* it was broken unless you unsure somehow that this can't be
> invoked on nodes which can be renamed.
> The ensures that the later obtained kn_name does not freed after a
> rename.
> This can not be RCU because ilookup() has wait_on_inode() (might sleep).

If it was broken, let's separate it out to its own patch.

> > > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > > index 1358c21837f1a..db71faba3bb53 100644
> > > --- a/fs/kernfs/mount.c
> > > +++ b/fs/kernfs/mount.c
> > > @@ -145,8 +145,10 @@ static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
> > >  static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
> > >  {
> > >  	struct kernfs_node *kn = kernfs_dentry_node(child);
> > > +	struct kernfs_root *root = kernfs_root(kn);
> > >  
> > > -	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
> > > +	guard(rwsem_read)(&root->kernfs_rwsem);
> > > +	return d_obtain_alias(kernfs_get_inode(child->d_sb, kernfs_rcu_get_parent(kn)));
> > 
> > Ditto.
> 
> kernfs_rcu_get_parent() gets you name from the kn. Can you ensure that
> it won't go away during a rename? If so, I would add the matching
> comment then.
> There is d_obtain_alias() -> __d_obtain_alias() -> d_alloc_anon() which
> makes not possible to use RCU.

If true, better to put it in its own prep patch, I think.

...
> > > @@ -216,6 +219,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
> > >  	if (!kn->parent)
> > >  		return dentry;
> > >  
> > > +	root = kernfs_root(kn);
> > > +	guard(rwsem_read)(&root->kernfs_rwsem);
> > 
> > Here too, it's a bit confusing that it's adding new locking. Was the code
> > broken before? If so, it'd be clearer if the fixes were in their own patch.
> 
> It dereferences name (later in lookup_positive_unlocked()). I don't see
> how it is safe against a rename without the lock.
> 
> If you agree that all three are bugs, that existed before, then I will
> extract it out of this patch.

Not sure whether they're all correct but let's separate them out.

...
> > I wonder whether it'd be better to rename kn->parent to something like
> > kn->__parent (or maybe some other suffix) to clarify that the field is not
> > to be deref'ed directly and kernfs_parent() helper is made available to the
> > users. That way, users can benefit from the additional conditions in
> > rcu_dereference_check().
> 
> sparse should yell at people if they deference directly. I have no
> problem to rename it to __parent if you say so.

Sparse isn't useless but also often ignored. Probably better to be explicit.

...
> > e.g. Here, it'd be a lot better if kernfs provided helper can be used so
> > that deref condition check can be preserved.
> 
> Something like
> | static struct cgroup *cg_get_parent_priv(struct kernfs_node *kn)
> | {
> |       return rcu_dereference_check(kn->parent, kn->flags & KERNFS_ROOT_INVARIANT_PARENT)->priv;
> | }

Maybe a shorter name?

Thanks.

-- 
tejun

