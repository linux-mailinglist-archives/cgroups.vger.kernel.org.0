Return-Path: <cgroups+bounces-6400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0CCA233DB
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 19:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395A7165BD5
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BFE1F150F;
	Thu, 30 Jan 2025 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djxx0YCK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04A1F0E55;
	Thu, 30 Jan 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262134; cv=none; b=X189T2+rrJK9RcMHOQ1UCc1E37EjRFRdHIFmmvxBekwFpfmEAlszrzWf4PVwIg0gEKDNPSX1ZIGXUoMQxm+pag3LlBSd0GzStABkW15j2sK8k6QZpm6Zm5lAmCXmqyI4lFiCIag3OWFuQBkg7eIF5J5QwXwJjWUaR0EFZBhz9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262134; c=relaxed/simple;
	bh=cDCRAJyX+SqCzd/IBi7tOrKWxTMdwlpBNKNo6yW6KWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu94Ajg6qNAIf94/VlWUwW3xkZMluaFwpNtuN0dfKaclS+3ikyhfpxp+C31DBu3zmwUt7NQDBUE1yx1N8aV/fCt4c4WUuFiI7h9vPfvlbUyw1xAMvDDMp2CyVHiSbDoLbyC3IAtFJz8qnBEZK7xM68kgPQSxOyfeB9u+I7ABBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djxx0YCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63676C4CED2;
	Thu, 30 Jan 2025 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262133;
	bh=cDCRAJyX+SqCzd/IBi7tOrKWxTMdwlpBNKNo6yW6KWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djxx0YCKb52uYNU2CLtPNQXLu555OYp49PW+rULyXvWhVs1Xsha38WG9wUHnAcrtL
	 au1CMU+V5ahARmCe3R/anayiLqwGG6j3B4V9jYh1iSoG/3hCXM3hOHoGabY1+MeU4f
	 IUdnswkAN1uquVrcc8LuML1kq7B7RA2KWpjp7V3k3SI6ZCczH8a9di7aEtxN/fu8IE
	 VKgvjiy8rOR3T2q11BSjPdO+5sZiqVAPxVnfN/PmnnDTCG+Frhl6GVF9No6E+veHJ3
	 54CuiJ5mxapsc+HytKIMOhEZcBPMrea5JCoKQwERiifWT3ds6owWywcP3FkhQURilQ
	 WP45poV4zDzyw==
Date: Thu, 30 Jan 2025 08:35:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de
Subject: Re: [PATCH v6 5/6] kernfs: Use RCU to access kernfs_node::parent.
Message-ID: <Z5vGdLDpHOdyIE83@slm.duckdns.org>
References: <20250130140207.1914339-1-bigeasy@linutronix.de>
 <20250130140207.1914339-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130140207.1914339-6-bigeasy@linutronix.de>

On Thu, Jan 30, 2025 at 03:02:06PM +0100, Sebastian Andrzej Siewior wrote:
> kernfs_rename_lock is used to obtain stable kernfs_node::{name|parent}
> pointer. This is a preparation to access kernfs_node::parent under RCU
> and ensure that the pointer remains stable under the RCU lifetime
> guarantees.
> 
> For a complete path, as it is done in kernfs_path_from_node(), the
> kernfs_rename_lock is still required in order to obtain a stable parent
> relationship while computing the relevant node depth. This must not
> change while the nodes are inspected in order to build the path.
> If the kernfs user never moves the nodes (changes the parent) then the
> kernfs_rename_lock is not required and the RCU guarantees are
> sufficient. This "restriction" can be set with
> KERNFS_ROOT_INVARIANT_PARENT. Otherwise the lock is required.
> 
> Rename kernfs_node::parent to kernfs_node::__parent to denote the RCU
> access and use RCU accessor while accessing the node.
> Make cgroup use KERNFS_ROOT_INVARIANT_PARENT since the parent here can
> not change.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

