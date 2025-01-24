Return-Path: <cgroups+bounces-6284-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD22A1BEE2
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 00:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E8169275
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 23:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDC1EEA28;
	Fri, 24 Jan 2025 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVWL6h4Q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383A1662E9;
	Fri, 24 Jan 2025 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760169; cv=none; b=HZCyC1ego5OAqMWefKMeBZOX/lcZPrw/v/sl0t1wK/nUGs09NVv3rdsLasKchPhjyJWyjdR1Q4GLyfVb/UoCh8b5pWGRtBAU5G19TEhQvSHnSTVkufhoCxbTENALVbTOfqdnESo1kKnuQx66F5SW1/m5KJ2bkk+Lquw8p0OZMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760169; c=relaxed/simple;
	bh=WsAoZz2CDcE9T6s2PSn0rUpzTNYd7l6+ooU+g77l96w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn3zdghPYs4i3i3t9ok+Yq4THpmvIkEpiUQXpm3gowSHTFkvLWc6qMwdutCAImp3pz4bx/Y9SYwcnqFbqU9vT/ZCXg0dNblMFrL3NzePw5zpkKXFO5ra4B3hfzLT5F72xbYbbOLLxycUoACimXQ7O8FazRQVy72BH2ib1gJXp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVWL6h4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9581AC4CED2;
	Fri, 24 Jan 2025 23:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737760168;
	bh=WsAoZz2CDcE9T6s2PSn0rUpzTNYd7l6+ooU+g77l96w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVWL6h4QOYLIWJtRkkrKTLCGcWtDixfA1C8DLfhoTIhZfou2W0qjVhvEAQGylHaFh
	 mmGsDtsCFzPX6z3PBuPVsHQL2OLvaTIS08FiE4DdgOPw+jOTSCnyBGcWfp6ceFayJa
	 rErVIBj2EAN7Ws/mE5v4fYkxLVlKLLqch1XJ9IgAUc1JhEnKdIh6eBO+2KhxdWG6ql
	 TY9rNXOKp5vmBGQZOu8Xw0mI3Cfklds7jmDsRcFViVoesaWfszOgSqy2pkeyH8dtP/
	 qQh+AvTdE6KQsswfHgJWuOHDiz+hFXGeQ4jD8OA+UEFQHrumng7au+bbZgUGIWRV1w
	 ztZO2NG3Cx4Rg==
Date: Fri, 24 Jan 2025 13:09:27 -1000
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
	tglx@linutronix.de
Subject: Re: [PATCH v4 1/6] kernfs: Acquire kernfs_rwsem in
 kernfs_notify_workfn().
Message-ID: <Z5Qdp5iX6Dzkw_ND@slm.duckdns.org>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124174614.866884-2-bigeasy@linutronix.de>

Hello,

On Fri, Jan 24, 2025 at 06:46:09PM +0100, Sebastian Andrzej Siewior wrote:
> @@ -911,6 +911,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	/* kick fsnotify */
>  
>  	down_read(&root->kernfs_supers_rwsem);
> +	down_read(&root->kernfs_rwsem);
>  	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
>  		struct kernfs_node *parent;
>  		struct inode *p_inode = NULL;
> @@ -948,6 +949,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	}
>  
>  	up_read(&root->kernfs_supers_rwsem);
> +	up_read(&root->kernfs_rwsem);
>  	kernfs_put(kn);
>  	goto repeat;

Maybe match the locking and unlocking order so that what's locked last is
unlocked first? Other than that,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

