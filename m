Return-Path: <cgroups+bounces-10136-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8339B58C9D
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 06:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E59F3B03C5
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 04:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C92C290DBB;
	Tue, 16 Sep 2025 04:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K10hM/g1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7BB1E9B1A
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757995338; cv=none; b=VgE19kkxyPXNmnKvXQoHZInt3BUFwm0wLCzBS4fihoOqX5efL3gGOqkhxjiEW/P3i8uWwjSMhSILlhUAPEZYsX//tLLoWnBfqtoknTBtJ5PF8+4v4wDjmlutYdKrzkQI/1spVwRSkFSd1lUT8HpSZhGnITEv3x2jTUA7xzozNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757995338; c=relaxed/simple;
	bh=UUJdIvJCTZLFaiyRA8ErYNZ9FoXcRHi1uaHJ0g63rzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ceEt1C04PlyuEaeOZ9XYYgbtUPnhzrHOoAl5NppQVZVGS4aLGcgdkncicNVjMp3Y3M/wUIsL6s57vLT8fFY2p6wXLiQzQQpGkHj/azvp9E25eUGjMDo1mwcaBhNYwkW9eJd9/NB9/J07Mr81qcVmbo50gWWf4v/2zMeDiJJd0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K10hM/g1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7724bca103dso4869295b3a.3
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 21:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757995336; x=1758600136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1AiCn6Yf7MLJOGQicoAhP1FNLIRBZVRzRsXqjBBBRLc=;
        b=K10hM/g1k1AvhzPxDF5uypFfT0DqOdenRIKNPlOu1fwz1/e7jg1md4eJpSy/4TcRXf
         KYb6ZBCJdgtAwOTFgDcG93zkZQ0yHK+8SLG7H+xtMotDV3d+y+tEafIU8J+E4CgGukYS
         hgUeFj5hqfRQbQwf909cIOj2ovV9tcAZnc6S9FekKO17ZKZVGd1MysKdluCbDbgvmOm4
         rdlg1VLz6Qlh+e+2UfqWcOOLT2YLzuAMIVE0fy5ZRdT1GJKHrXB0PoW5V4u3CUQtO8Lg
         XRpsEZo3PZ4KvAokR3QgRhm8hwiQXbFYfN8gONSpYVEzvEBJwGkjR3E/3ctLGmZfOIV3
         6f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757995336; x=1758600136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AiCn6Yf7MLJOGQicoAhP1FNLIRBZVRzRsXqjBBBRLc=;
        b=bsedsdtYwBtIwAQWSxKg8qjRVzl1i2gdu1EQ2tbDf6MBjyuTKavGMO7Dt2qSAlEJTX
         kIZemhLZUCB+o+//BEQWq+QwjIVvVnfoa5ECf91Iyp7DSBXI91//yiuXTYz461utxSWD
         TuiII5eETE/PNmiTHUykV1NPJ/ijJ0sawrJS8A2+5tuqlnNGo+S3GN/StSowCX2BQx7t
         Hy4DhSY4SP+wfSPxavbX/1iKmT08xAEveb5BBN+4A3MQuYoLlpk54hT6ID/Bio6YAIuO
         y1qk3YJIcoEsfmFhboJxCh0XOtHT7qz0ZZRfRtypCPViqgM/AaOKumiib1Fc2JFpUGQK
         IA4g==
X-Forwarded-Encrypted: i=1; AJvYcCWcdyjWfuG8dDQwgTyHgrtkab4X8ghpdJROyNMuKWlo/Ns05l0NVYDf60TTeicML5LLJ7XRLAoh@vger.kernel.org
X-Gm-Message-State: AOJu0YxNKLTZ+b2usA2Sz6tNntUXlsXrn0M8ZBGKxek+TrDz9mSsrBVM
	pkAwHneG+fH07uJDauKgFNP0s6QFrbDOQVBM/fdZJrYweFMaOh/wABjk2O+CK6M/cOqqK20NSnb
	w/TG7dA==
X-Google-Smtp-Source: AGHT+IHvLTztZLDVxTI+gM0wu0lDoOjAwawu5SNGK91k8BlfCEFiK50xU/x2OHJPmawz0vgErtwtv7TKzRw=
X-Received: from pffr10.prod.google.com ([2002:a05:6a00:216a:b0:772:3e53:6d20])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e09:b0:76b:ec81:bcc9
 with SMTP id d2e1a72fcca58-77612168c6bmr15901933b3a.21.1757995335625; Mon, 15
 Sep 2025 21:02:15 -0700 (PDT)
Date: Tue, 16 Sep 2025 03:59:34 +0000
In-Reply-To: <20250912-work-namespace-v2-21-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912-work-namespace-v2-21-1a247645cef5@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916040214.319783-1-kuniyu@google.com>
Subject: Re: [PATCH v2 21/33] net: support ns lookup
From: Kuniyuki Iwashima <kuniyu@google.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com, axboe@kernel.dk, cgroups@vger.kernel.org, 
	chuck.lever@oracle.com, cyphar@cyphar.com, daan.j.demeyer@gmail.com, 
	edumazet@google.com, hannes@cmpxchg.org, horms@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, josef@toxicpanda.com, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-nfs@vger.kernel.org, me@yhndnzj.com, mkoutny@suse.com, 
	mzxreary@0pointer.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	tj@kernel.org, viro@zeniv.linux.org.uk, zbyszek@in.waw.pl, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:44 +0200
> Support the generic ns lookup infrastructure to support file handles for
> namespaces.
> 
> The network namespace has a separate list with different lifetime rules
> which we can just leave in tact. We have a similar concept for mount
> namespaces as well where it is on two differenet lists for different
> purposes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/net/net_namespace.h | 1 +
>  net/core/net_namespace.c    | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 025a7574b275..42075748dff1 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -11,6 +11,7 @@
>  #include <linux/list.h>
>  #include <linux/sysctl.h>
>  #include <linux/uidgid.h>
> +#include <linux/nstree.h>
>  
>  #include <net/flow.h>
>  #include <net/netns/core.h>
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 5fb7bd8ac45a..169ec22c4758 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/uidgid.h>
>  #include <linux/proc_fs.h>
> +#include <linux/nstree.h>
>  
>  #include <net/aligned_data.h>

nit: This is no longer necessary.


>  #include <net/sock.h>
> @@ -445,7 +446,7 @@ static __net_init int setup_net(struct net *net)
>  	LIST_HEAD(net_exit_list);
>  	int error = 0;
>  
> -	net->net_cookie = atomic64_inc_return(&net_aligned_data.net_cookie);
> +	net->net_cookie = ns_tree_gen_id(&net->ns);
>  
>  	list_for_each_entry(ops, &pernet_list, list) {
>  		error = ops_init(ops, net);
> @@ -455,6 +456,7 @@ static __net_init int setup_net(struct net *net)
>  	down_write(&net_rwsem);
>  	list_add_tail_rcu(&net->list, &net_namespace_list);
>  	up_write(&net_rwsem);
> +	ns_tree_add_raw(net);
>  out:
>  	return error;
>  
> @@ -674,8 +676,10 @@ static void cleanup_net(struct work_struct *work)
>  
>  	/* Don't let anyone else find us. */
>  	down_write(&net_rwsem);
> -	llist_for_each_entry(net, net_kill_list, cleanup_list)
> +	llist_for_each_entry(net, net_kill_list, cleanup_list) {
> +		ns_tree_remove(net);

Looking at refcount_inc_not_zero() in nsfs_fh_to_dentry(),
I think ns_tree_remove() fits better in __put_net() which
is called just after refcount_dec_and_test(&net->ns.count).

cleanup_net() is single threaded work and somtimes takes long with
too many netns and the netns may stay longer unnecessarily until
next cleanup_net().


>  		list_del_rcu(&net->list);
> +	}
>  	/* Cache last net. After we unlock rtnl, no one new net
>  	 * added to net_namespace_list can assign nsid pointer
>  	 * to a net from net_kill_list (see peernet2id_alloc()).
> 
> -- 
> 2.47.3

