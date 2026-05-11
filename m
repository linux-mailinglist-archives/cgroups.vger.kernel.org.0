Return-Path: <cgroups+bounces-15712-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FTmF0JDAWpwTAEAu9opvQ
	(envelope-from <cgroups+bounces-15712-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 04:47:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF215074E0
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 04:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E56CF3001A42
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C7435DA6C;
	Mon, 11 May 2026 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mcK52oTj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F51A682F
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467642; cv=none; b=NzULJqWTmmpULeY2xl3O6q1e1/z0HSNcb7uNRMN41yfygTIODHcwxzKdD1Z4S7DP1EBNtzwUocs8m3JKwasK2Y4qtJg+X4p0mh3HfDJlTThIaxy+rbMXZqp0a9kaD8d56IO7jzXF3kVpgTEt+XbPe5STpM/ONE+JJicZGsT4yCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467642; c=relaxed/simple;
	bh=k6NApm+olFkXSQ+kxEGbkEYlLu6TBi3SimT4+3HDyXw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mtskjvl0gSWfb7F2QKQQi3YJ4iGXQT+Peu+ogBBDRx0tmuiLJbhmVUzO1xC2mnnqGXw+zQHCauX0/9VOoanjx9+iU4gFtPWQuIEMAJ0gP7iNRwes3TmmmS+8cem4oAyBZ+Mp7yEIxcwXJZxE6dF67mB26d7AajqOHHNvX8bZOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mcK52oTj; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778467639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3SwfQTRstxGAWJOQrDfplfV/r0dJnk93kn46PHmRmA=;
	b=mcK52oTjOdqXICVU/+QRzwUY2kZ+/hvTdAxifTWyazCwjrZEWyA8b5xvPXfYUQ/1ourdEF
	UPJ3X5zZbgmrUwqqfEyU3Z6d5YEQe8yDj7X6zAjwoh933/j0IyezeAHfMD0jDxNj6B9jAz
	OM+nDZ+/GRW2zuUl61Bb0tU9pBgf1hw=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] selftests/cgroup: check malloc return value in alloc_anon
 functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260511021615.1768623-1-lihongfu@kylinos.cn>
Date: Mon, 11 May 2026 10:46:41 +0800
Cc: hannes@cmpxchg.org,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 tj@kernel.org,
 mkoutny@suse.com,
 shuah@kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EA4FB6D8-52F0-4135-8EBE-0B26BBA9D303@linux.dev>
References: <20260511021615.1768623-1-lihongfu@kylinos.cn>
To: Hongfu Li <lihongfu@kylinos.cn>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5FF215074E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15712-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



> On May 11, 2026, at 10:16, Hongfu Li <lihongfu@kylinos.cn> wrote:
> 
> The alloc_anon() function calls malloc() without checking for a NULL
> return. If memory allocation fails, a NULL pointer dereference will
> occur when accessing the buffer.
> 
> Add proper error handling to return -1 when malloc() fails in all
> four alloc_anon variants:
> - alloc_anon()
> - alloc_anon_50M_check()
> - alloc_anon_noexit()
> - alloc_anon_50M_check_swap()
> 
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


