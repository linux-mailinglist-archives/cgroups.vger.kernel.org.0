Return-Path: <cgroups+bounces-13953-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKZwBu+Ej2mRRQEAu9opvQ
	(envelope-from <cgroups+bounces-13953-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 21:09:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD3D13952F
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 21:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7698C3032769
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5D5279DC2;
	Fri, 13 Feb 2026 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ISJN1gNM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8FD250BEC
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013350; cv=none; b=myz4rBtyB97UmyYuC9LbXTkCoKpb/x5b88LBDwguXYNFigwc95+5g7aAiBHD5seoJOZOmEUagK8DW5DGHyH/QTDTzE/J04uFdWKf2NLhWbCgZLTKkSJYoKqjSMPz8GGONWtSw8Q2gHKVKyGFM8+XIHxxWGYMRcF9wOcmLZUM/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013350; c=relaxed/simple;
	bh=grx87uhUn214R0/16Oz25CTUsC7j9HEq906lrr+h3BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fv/53yK0Gi4YUlwQL4lErXziujVoJ17g60o0MxmTQJZowrxcvFlDG7w6VhapIsS3BhviSwKmx79tdYdU6snXs8ZwXLh6IWOm9TPLyJJr/Vz5/700VTTWV0Y694b2VE46B7D3QyH1sLEfWjsBXalnM0SlXieWtFqSsw+AWql0AQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ISJN1gNM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb3fb47559so128864485a.1
        for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771013346; x=1771618146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qPVnjkUUN7g5ZDl/2W4jZj/HTnTNtx2ZZEtCyQsavo=;
        b=ISJN1gNMABWfEcEWMcyhsdgo47V34/ALFe2OAjLgxd/QJYVOTlYx21N0K4YvOGsqGR
         IMNoqTAU3j+qVs3ypYQozP+fIIiluWv5w8z3ItT32q4wLYJe3FOrp888OS9i2y/mcQru
         2DuTAyahPq6QW2lrZBTHL0tJZ+hKa/9SpZ2hT3dxo3//u2qGrRn6h7/+54kQCmD8PDzG
         0Z5/gdoUt/Kl9cFEJWy/15pvyIKMxIuodSRhjJob82yLXFdaUU4xtJyp9MBNt8K9vhF/
         dgEvRKvIhxRVyPFKiHHsHAB0p0ul3khzh/0edKI8myov36ARug9WOo98onbK2FuICTnC
         qaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771013346; x=1771618146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qPVnjkUUN7g5ZDl/2W4jZj/HTnTNtx2ZZEtCyQsavo=;
        b=uGBLOk/ngQR1uHvCy6Tv6zeNPiJthEZmg5A9p43YMsUVyD/jrB2wUlUCiQz07W4bT+
         0G+Wpe8YpYHIfF7r3BJ2UGFScce1UCT8bExd60r7YLsx/C6us0aS91hdBLJ637vemlqe
         OCQEo3tGPRKhavs8Zho2GmYQFkrNjzTNvnsM5vLvy0ZpSIumpSLvUU+U6eq5xLfJrRI0
         +aZGOoR2GnmtuWmGU+rx58GEIVsh5IC34BLz9cIXa2u39zTidHOqXFxvG+AYMZ4B7rWl
         DWfmrWYgZtcACO8IZboVJWxzKjhbmC3dbVWULpWzOrSsB4Ku+0x36/ZKcBZ8ZiLc/Qm9
         T1Bw==
X-Gm-Message-State: AOJu0YxFtI0jAz3JrHhxKwP8eT1YncE+WvgKizMpynOG23lAYGcygf0P
	M9wnnCE53ys8VQ1DaHfEB80GQ9//BS+g3ByzKHiJoHxumn24rBfau8J3IlcasM88Eqw=
X-Gm-Gg: AZuq6aI1MNLpNVzIEYzPeMHjt2kiygyrhcXulWCW94du3m/YZnsLIqzaJGrKAicYtsx
	8f+FyeetDijlwF2tlXuhUtFRhViyZVHt+I7Mpx8l7K19SAZ5jhb/3qYlYmg7Bb49qh1Y4gGuPQL
	VEmnptthd0Wm35eaTC0H9CziCQpaVfrIDPA47YZgw8OrQGlDwSoFtOVbtIFsg3uwVFAa9oB2Ru/
	k/47wwLQ6+qq2WT0tmdPMji+8AzdEEKqmFk55FmqnyqhM32/HKNi8lXodaZet/zhugmhqPWk3LT
	YMHYl8aOYZUsTdjTyfXVnEfNAA0zuJd/rZ8nuvp3yT0UpDDo1AgJqlLSPRrC/EmDenGvgwLSMyv
	Un/bV/Zv7WthaFM6ddVDxOjfH8hB5byU723KCLIZgcpGgmsJ0ILHZzCgGE54tbr84v7VIuy/pwm
	49Z9iA5fw9pOBxf/wJvkUKgg==
X-Received: by 2002:a05:620a:1a13:b0:8cb:3bca:bb3a with SMTP id af79cd13be357-8cb4249f104mr378592785a.67.1771013346200;
        Fri, 13 Feb 2026 12:09:06 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c7ef7sm723625085a.28.2026.02.13.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:09:05 -0800 (PST)
Date: Fri, 13 Feb 2026 15:08:57 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH] memcg: consolidate private id refcount get/put helpers
Message-ID: <aY-E2Rj2gBrBHJsT@cmpxchg.org>
References: <20260213-memcg-privid-v1-1-d8cb7afcf831@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-memcg-privid-v1-1-d8cb7afcf831@tencent.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-13953-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ACD3D13952F
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 06:03:32PM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> We currently have two different sets of helpers for getting or putting
> the private IDs' refcount for order 0 and large folios. This is
> redundant. Just use one and always acquire the refcount of the swapout
> folio size unless it's zero, and put the refcount using the folio size
> if the charge failed, since the folio size can't change. Then there is
> no need to update the refcount for tail pages.
> 
> Same for freeing, then only one pair of get/put helper is needed now.
> 
> The performance might be slightly better, too: both "inc unless zero"
> and "add unless zero" use the same cmpxchg implementation. For large
> folios, we saved an atomic operation. And for both order 0 and large
> folios, we saved a branch.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Nice improvement!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

