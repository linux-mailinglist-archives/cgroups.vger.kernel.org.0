Return-Path: <cgroups+bounces-7837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93762A9CCD7
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 17:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9701697E4
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BF327BF92;
	Fri, 25 Apr 2025 15:26:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C249266B66;
	Fri, 25 Apr 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594773; cv=none; b=SHrLIjwvPRXZhau/sQrzAEQGob/Wgh1l53O+CGHXyOxLyWadC/nJkeKUdPq1P0qgVf7fcjfPrxZIp62WJXNeMj4iH0G+GS8x8hOACrjtr2b3U6TKWhbCD5VOnAr7o2dj5lmrChyNw1J66P19d2MUrcxzdMd0GJQVcDPPDAtGC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594773; c=relaxed/simple;
	bh=ddkkbUdIg6qoRo81kIcRLbLOkvg0fZeg8lMrb9HfdL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT4qIukh66MUJs9P3uc6egy6kPT8XJl2PTL6VSgVu/yOlqDPxEAxrrWHZeQPELC8rtjkRCVzBy1AjvXTT7CJKsalqP/I8ICHk36Qbkaa925PN0039A8v0xWTf8gW1FpXin8XL418e0QOBZGwWGnfDmHjEjLHAkNDu6P6km8oNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B784C68B05; Fri, 25 Apr 2025 17:26:04 +0200 (CEST)
Date: Fri, 25 Apr 2025 17:26:04 +0200
From: hch <hch@lst.de>
To: Waiman Long <llong@redhat.com>
Cc: hch <hch@lst.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cgroup null pointer dereference
Message-ID: <20250425152604.GA15999@lst.de>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com> <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com> <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com> <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com> <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <20250425145450.GA12664@lst.de> <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com> <20250425151140.GA14859@lst.de> <8a85a074-d4fe-404e-9438-131963a51051@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a85a074-d4fe-404e-9438-131963a51051@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 25, 2025 at 11:22:50AM -0400, Waiman Long wrote:
> The nvme-6.15-2025-04-10 branch used by Kmaljit includes some v6.15
> commits like the cgroup commit 093c8812de2d3 ("cgroup: rstat:
> Cleanup flushing functions and locking") but not its fix commit
> 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with
> cgroup_rstat_lock"). That can cause system crash in some cases. That
> problem will be resolved if nvme is rebased on top of v6.15-rc1 or
> later as the fix commit will be included.

The nvme branches are always rebased on top of the current relevant block
branches, i.e. block-6.15 in thise case.  Everything else would create
merge issues.

