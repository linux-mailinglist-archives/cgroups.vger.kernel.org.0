Return-Path: <cgroups+bounces-6363-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89171A21336
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 21:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDCA161B85
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 20:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFC61DFE3B;
	Tue, 28 Jan 2025 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXlou34i"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8B1A841A;
	Tue, 28 Jan 2025 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738096810; cv=none; b=IrsU+N1huS5Mkz9rd7UxukFP7/9qK9+fQzuqxhlWjZIinUxHunJindNdZ9vd3NmjpmEWCjeUb2PHqFDX3HZvqesSfLX6v8xPai6pAdYrQR6YpAGE3woPDOG2NCunbNm3YTDSMfGiTXxWjZHxQSt/BPLODCuajA7MWGo1zmHoQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738096810; c=relaxed/simple;
	bh=1j7nluAEt3C73FW8+P7X2NnqOM0asdwSy/C1mUguSvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNU3kRdkGtps8j8Vcv7qHWioP6nKXc7a0+eiWTMS6s0m50ZN9Joopp9YU3Q6YmPAYfwf17edhcx31c19rQz/wTsA78r2+6INCtwoj8tdZD37KJNrCpDs2GCqNfgL9YdCP13XOdtCkxHfE5xnApt6XApqd25u4EqDEr2L/7ipw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXlou34i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6F2C4CED3;
	Tue, 28 Jan 2025 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738096810;
	bh=1j7nluAEt3C73FW8+P7X2NnqOM0asdwSy/C1mUguSvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXlou34iWmulRU89iolNvGlbOMRu2oZTILJK7be79nw0riJmbAm3BcXs7ztx9negD
	 stcNIETOdNx6PdfHNs1cUhRNNYkCwmoeBeiLQRl9qV9iOffoAg+Exxa9mfOpKOh1UZ
	 jvfaMlbQB6n4DKHCsIGxZbQVeOv0lbwXp6EvIzF1H5FTlYNrvqGzUnRLQ4JGDNKfCP
	 uwEbAhH/BT/QmOx0R9limLKcIox9Q3Zj3XTVp22SbioBpYvixO6bq5/iNIaWrntz6t
	 eKYEJubeLE8tmwMhQJC/W1ssq4LKWRpdFscj/7PH6lxQM/QpstSXcIU63FycbZpIkT
	 IvGNcFKFjIEeQ==
Date: Tue, 28 Jan 2025 10:40:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 6/6] kernfs: Use RCU to access kernfs_node::name.
Message-ID: <Z5lAqVmFkMoFACae@slm.duckdns.org>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
 <20250128084226.1499291-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128084226.1499291-7-bigeasy@linutronix.de>

On Tue, Jan 28, 2025 at 09:42:26AM +0100, Sebastian Andrzej Siewior wrote:
> Using RCU lifetime rules to access kernfs_node::name can avoid the
> trouble kernfs_rename_lock in kernfs_name() and kernfs_path_from_node()
> if the fs was created with KERNFS_ROOT_INVARIANT_PARENT. This is useful
> as it allows to implement kernfs_path_from_node() only with RCU
> protection and avoiding kernfs_rename_lock. The lock is only required if
> the __parent node can be changed and the function requires an unchanged
> hierarchy while it iterates from the node to its parent.

A short mention of how avoiding kernfs_rename_lock matters would be great -
ie. where did this show up?

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 955999aecfca9..cc83dbc70a8ef 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -505,6 +505,11 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>  
>  extern struct mutex rdtgroup_mutex;
>  
> +static inline const char *rdt_kn_get_name(const struct kernfs_node *kn)
> +{
> +	return rcu_dereference_check(kn->name, lockdep_is_held(&rdtgroup_mutex));
> +}

Maybe rdt_kn_name()?

Other than those,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

