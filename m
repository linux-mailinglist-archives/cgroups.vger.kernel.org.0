Return-Path: <cgroups+bounces-15470-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA+FG7tT6mkhxgIAu9opvQ
	(envelope-from <cgroups+bounces-15470-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 19:15:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47445566A
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 19:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C413060AC5
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139D5399356;
	Thu, 23 Apr 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwWKJXLl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC13939C2
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964248; cv=none; b=gnn4KdjX+AN4WC03GjCP1EWobqssGDEz9davOBnFvLpTQUEG1GfAzIIt5qq5Oc+J/IMXthjPj1Cix0hZv1fVLOe5ue5j4KVf8CbZNx3WadFYuYyQFTBeKnwIzvsMiQB1aCGVlUK3pSbvqGkBEeFgNl0Z9oT9CEpPR3RKKijufXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964248; c=relaxed/simple;
	bh=hX9F8kdLNx70ioDubS+/i93zX1Trsizx/SyjS6quf0I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hCNE/vs9GR7TrXEkGsj20nC7DeL5p370OzEtqEals/+e1Ib1tXJ+b3HT1U0uNhF1iVHJgDWF0OQoMJysxcrD2o9qJFk7/xkRl6rNzNWUQkRY7s99Et3Owi5gsia1a2w8AASgVXoxaY23MWBeTnFbf9g5K7vsO0Kkz7KIrBQRTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwWKJXLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC51C2BCAF;
	Thu, 23 Apr 2026 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776964248;
	bh=hX9F8kdLNx70ioDubS+/i93zX1Trsizx/SyjS6quf0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uwWKJXLlI5CqdrwxkEKodYK+zoWVK+zwcIrH1Bl9HMnIgAcJyfs/SGKlc4a5RJLZ4
	 KBkj/qbYgYi+l70LLvDcaMn6GUCpks8iSRzlgb6tdhHoMC4RpBZlDpzz7GxRvSYU0e
	 Gh4OufPIdKP/C+7KVMqH0FBlhrEBgruW3Mh+qzEz8jVM3XmArlsMyKuOnnbK+Let9R
	 mur9+uvCZRjTErG1MknkLpbTyrG3PpGwshQ/yNPDzhx8PwdUmvmbwz+WpOTAIn/boM
	 G7zW0heXnyp6qPJeC+itZBivTvfrpLyTDmf+OK2OHDyJK+20rmJgNEK/Sa3Hdhocc+
	 r2UEF1aLMqOyA==
Date: Thu, 23 Apr 2026 07:10:47 -1000
Message-ID: <6c716f14922b20339c2d4f11322f6535@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org
Subject: Re: [PATCH v3] cgroup/rdma: refactor resource parsing with match_table_t/match_token()
In-Reply-To: <20260422021709.333689-1-cuitao@kylinos.cn>
References: <20260422021709.333689-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15470-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE47445566A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Wed, Apr 22, 2026 at 10:17:09AM +0800, Tao Cui wrote:
> Replace the hand-rolled strsep/strcmp/match_string parsing in
> rdmacg_resource_set_max() with a match_table_t and match_token()
> pattern, following the convention used by user_proactive_reclaim()
> and ioc_cost_model_write().

Applied to cgroup/for-7.2.

Michal, please holler if you have any concerns.

Thanks.

--
tejun

