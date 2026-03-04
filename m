Return-Path: <cgroups+bounces-14608-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHaxCANiqGmduAAAu9opvQ
	(envelope-from <cgroups+bounces-14608-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 17:46:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 776472048E5
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 17:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00DFF3002287
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65AC35FF66;
	Wed,  4 Mar 2026 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJekaLHE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340D36AB7D;
	Wed,  4 Mar 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642553; cv=none; b=SmGIvvi9jTVg/JGdDJqgbKmalrKoRtYDNGm32tskFgENp36t2cbz9CPVTbpwNqxXwc9I0P2CdHVcWrHT9LL1WGMwIfIM4LVPXBZSfuPxfCuUpVehHrzZ9I7Y8eC6rocCxM9oqsM0urgUmDtdnZMoqxoqkwiGD4QyjCAskoyUhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642553; c=relaxed/simple;
	bh=PUN9MokrNUQzb1CRuNzEuvihL2Rfl4GYvtOUTRwsVH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBtH/INCb4dPWNwZC9YaLNXcxjW/Z4rDBFRi7y2l190VHZJS1r4BNS1IFfiHPWKbCbwHgOT5Q+CNhjzVE5xtHBK3Ib0pDRyeYBtXKv67b5G18NZAorCkMW0s3WAnPA3EYx8xnENTItl1cSs16DXm1lCxQQvRMXVqD7AyZA3O3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJekaLHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4632FC4CEF7;
	Wed,  4 Mar 2026 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772642553;
	bh=PUN9MokrNUQzb1CRuNzEuvihL2Rfl4GYvtOUTRwsVH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJekaLHEc6yHM0DWkmu6wUVO7dUymf0IAb+kvnxU6m81luYkPmU1UFN7FB2W0lFjB
	 neMK82ko9l6EfyrLQlD3nBx8cFpbahfTGiyPABju3bj4ci56UV7Azx0GLvYtwVCmHL
	 1LqIx2DegU07+QgFYk7hP7DgmEye2ADD33HW6M5YHpRN3upHOLV+SjHEWWgXyfa4TO
	 xHpb94R1UxmxbUOVp47K0+JpW1yVL5c+5TZOjmXfdCOw5q2Ydl/HzBOu6cumbYyOSV
	 Y5Zgxq9msTcoQCadMWT6WyKkB8sp31DUaZ40ylxB84I8EH1LMUbPY63XN8dvZt1eOj
	 Wwo+PpS/ZE7OA==
Date: Wed, 4 Mar 2026 06:42:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	thevlad@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
Message-ID: <aahg-PreSQLlNq2p@slm.duckdns.org>
References: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
 <aacehv3rpO9irhEG@slm.duckdns.org>
 <poawwl44nvy4ru4mmjqi3kxfq7xqcpdeq6ghixphcrwhpv3bnz@xsltjt52rbqm>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <poawwl44nvy4ru4mmjqi3kxfq7xqcpdeq6ghixphcrwhpv3bnz@xsltjt52rbqm>
X-Rspamd-Queue-Id: 776472048E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14608-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,slm.duckdns.org:mid]
X-Rspamd-Action: no action

Hello,

On Wed, Mar 04, 2026 at 02:28:03PM +0100, Michal Koutný wrote:
> On Tue, Mar 03, 2026 at 07:46:46AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > has not been modularized since commit 32e380aedc3de ("blkcg: make
> > > CONFIG_BLK_CGROUP bool"), making the module parameter a historical
> > > artifact. Readers of the nested-keys format should be able to handle
> > > additional fields.
> > 
> > I'm not sure what the above para means. Module param works just fine for
> > built-in modules on both boot command line and through sysfs.
> 
> Yeah, it works but BLK_CGROUP is not a module/built-in it's config
> option affecting builds. I find the module_param() in blk-cgroup.c to be
> a residual, I admit it's convenient way how to expose a tunable to
> userspace.
> 
> (Contemporary way of implementing the option could also be a cgroupfs
> mount option/feature or maybe sysctl for which tooling is available.)

I don't konw whether I'm the only one doing it but I use moduleparams as an
easy way to get non-API boot and runtime toggles whether the target code is
actually module or not. It's easy to use and the params are in a pretty gray
area in terms of API stability, so if you wanna throw in a debug option, it
works.

Thanks.

-- 
tejun

