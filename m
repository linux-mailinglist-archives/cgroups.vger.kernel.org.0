Return-Path: <cgroups+bounces-6633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508CA3E5C0
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 21:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09138420C83
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E51E9B25;
	Thu, 20 Feb 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xOwgciiF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D81E633C
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082944; cv=none; b=c5gsDE2amkThfFjTFAmlz9uH5E4BWLs8cShq3JaMOFmgUwginX1p97+Kfgtwff44vPoln6GOo7Fk4QR78LK7Ck7s1T71+7oe6zH7RirsRG0uWqHAtXCLkywYxrvs2eBfdg+mBurCakNTzucbS8vxyNPibSZJ/nycReQgxk4I+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082944; c=relaxed/simple;
	bh=o1DVkTJ3wbmJ5LI04FyppCzlahZhwIHVpaz9/LrVc38=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=gVJjmtTfkdvyrldy0H3di47pjv9iHFxS3avnMm355NXYXQaiIAEN86pCdtKWk67GtbphQesMh7OTOvRCYvO/5QhRXepmctpT7Fbiew7Zmd+IbSWoqTj9IFhx+SW54IeKUmDPm3fDrR0P9yVCkrOuwssrEKT9VYkJSW392BVGyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xOwgciiF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740082939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKeHDTPUMbBHbLZBwItw3bMF0jmhlOcG0J5q3cjyQvA=;
	b=xOwgciiFLizt88nS22ko8ZDXVCXAHLhgF04vRMOM8WVZUfeeB4YbDZ8bQWPY6FsgUR2Q+h
	IcZkSW2E1niRnVKEhwRyXmIc5LGzW3H/hlcN4huOIKilunufckSOg2VB2b15+OJEF8M+QF
	LS01nU8bGBJiqIOgKvwFkdfvVwGg/Ws=
Date: Thu, 20 Feb 2025 20:22:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <07c9e4355ad4e3982d288306dddf18b391082b14@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
To: "JP Kobryn" <inwardvessel@gmail.com>
Cc: "Shakeel Butt" <shakeel.butt@linux.dev>, tj@kernel.org,
 mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <Z7eKslSmYU-1lP3u@google.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <Z7dlrEI-dNPajxik@google.com>
 <p363sgbk7xu2s3lhftoeozmegjfa42fiqirs7fk5axrylbaj22@6feugkcvrpmv>
 <Z7dtce-0RCfeTPtG@google.com>
 <158ea157-3411-45e6-bca4-fb70d67fb1c5@gmail.com>
 <Z7eKslSmYU-1lP3u@google.com>
X-Migadu-Flow: FLOW_OUT

> >  Yes, this is true. cgroup_rstat_ops was only added to allow cgroup_b=
pf
> >  to make use of rstat. If the bpf flushing remains tied to
> >  cgroup_subsys_state::self, then the ops interface and supporting cod=
e
> >  can be removed. Probably stating the obvious but the trade-off would=
 be
> >  that if bpf cgroups are in use, they would account for some extra
> >  overhead while flushing the base stats. Is Google making use of bpf-
> >  based cgroups?
> >=20
>=20
> Ironically I don't know, but I don't expect the BPF flushing to be
> expensive enough to affect this. If someone has the use case that loads
> enough BPF programs to cause a noticeable impact, we can address it
> then.
>=20
>=20This series will still be an improvement anyway.

I actually just remembered. Using BPF programs to collect stats using rst=
at is currently independent of the CGROUP_BPF stuff. So I think this appr=
oach breaks that anyway.

