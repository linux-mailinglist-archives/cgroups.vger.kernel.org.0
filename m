Return-Path: <cgroups+bounces-16215-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAm1OqaEEGpJYgYAu9opvQ
	(envelope-from <cgroups+bounces-16215-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:30:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A35425B79C2
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A83130086E7
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F13A0E94;
	Fri, 22 May 2026 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIebCu8w"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DE346E7F;
	Fri, 22 May 2026 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467079; cv=none; b=kLOwP5uPqTncQAB9ydVn/5WGftlm2u35UxUL2MSV+14gOYRpRSL6iu/sLGQu7FHwxfIjZ+GYnBMBoVXZieI/TEyjd4VqP9jL70phKouyWFmSnUMqJQzxg8sgRwS/DkZY1k0gHwPPviYQGctOZxmO537w2ysD5DssaHE8/JPPY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467079; c=relaxed/simple;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFuO8N7s1GjxJdZ7oXns0rt1RDWwmmXZRqmK7vBOCJwIoPDOl4BwrcGvo9pGVGSA341ZeEMph/cvPYbLGmFQetwybiR5/bSCIxYw1BMIs3KidJ/9N6fL2Kr4LPBOt1L2yF0Xv5zna9hpYLA4QDBCUwq2GAtDcZZAlul+rq4E+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIebCu8w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CD81F000E9;
	Fri, 22 May 2026 16:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779467078;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XIebCu8w/5EIsnTAkusMssIT/oJ++zXZHLC1bxea4xQ8RIVifoo61GRKbJnWBCT11
	 px8/BWJ1FsE6P8UM0bHpDrBhDalyvGrHouJBfM0NCg7hDMzjwSUfPPT9zA2+3EdUaA
	 6W8O3aSeK+6T2YmpeLi6rdxg1Kc4iOCZm+ZiZEvu4sQruxZ9wZQOccShdL+d4mVRaA
	 pVnBCTP6bm54v77PyYTnxkhFgNFA8R9pAizBvIj1HroEMZj52iF9qj1hs62LL9/Dih
	 C5+J7RB9P5cPL2SgUWFq3MnK5PFOKbQnxQhuCkIZevGpwBVrtK0cDtVC5Pum/iKjRX
	 YjpkbyS2oy+qQ==
Date: Fri, 22 May 2026 06:24:37 -1000
Message-ID: <1644404988c5e2d333a9d09399533dcd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	=?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: enable memory controller in hugetlb memcg test
In-Reply-To: <20260520093130.490020-1-zhangguopeng@kylinos.cn>
References: <20260520093130.490020-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16215-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A35425B79C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Applied to cgroup/for-7.2.

Thanks.

--
tejun

