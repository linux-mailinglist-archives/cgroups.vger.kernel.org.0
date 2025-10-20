Return-Path: <cgroups+bounces-10900-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E7BF299A
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 19:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487F0465CFF
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A931355F;
	Mon, 20 Oct 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2RvImse"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9719F115;
	Mon, 20 Oct 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979776; cv=none; b=i0HROKl0wMCK564qide68VdibaAnSzH5d3SLlbzpPYh2qZd9xmeEIRLxOaoVpDRTG/U6L6tnnBg7NjxlEwoxH1sy0Rhi/qfJg7kQOCp8f6ex9bYBctxmiXqCAPlNzet8n3AWUCADqata3LDC2/x22CW01c8Yo+WQgbbxGkYYbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979776; c=relaxed/simple;
	bh=b/uijNLG1Y9w1QbpfiKv/5ZeoIftCLv6RAYHd+pnw4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQsMtusgDF6i87LZmPzHKCry9aWiISjTcY/Abg+DHdlB1/qEHuRFMTDGwanMLk+4H9AsJa+bm72X8Cnwg+d8pdOXUucYTYslq4f3s1k44HWZFyatcM74N+hYDWOS555A9L9JBjOSITi/iA96ldPRQ0DLW6Vl8KGjvvOu1i8PZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2RvImse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C637DC4CEF9;
	Mon, 20 Oct 2025 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979775;
	bh=b/uijNLG1Y9w1QbpfiKv/5ZeoIftCLv6RAYHd+pnw4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2RvImseKwLZ+2THSpBFZGArEcQPDjx0Pz0vSju19B29hCIUWiUl5o+QWZ43eHDGA
	 qCRyTR3D4JaMVOhb+jGNqqn+3aGhCtsdJTOHtQFBH+FBkce6Jdf5HA29iku4oQpbGj
	 APp4GwT0NDMI1nOn731I8hG3hC93tOVnhprmDXIAu9kpzH2ImJfSBe9m8DztvPqtoy
	 WhMxH2X9pgb3zhDs4QqvNddzmnGxOf3KWPbtXZHjAYaeyws4fIPtp/7FLf4fNU2GOo
	 7n86iNWQDrLuY/lFerBHfwqDTMYkfLx3kZ6sBsFaACfQoeN63Ge93DunOfzOUy+TF4
	 lo40uhVYn3e0w==
Date: Mon, 20 Oct 2025 07:02:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 1/2] cgroup/cpuset: Don't track # of local child
 partitions
Message-ID: <aPZrPh1NoyncWPA8@slm.duckdns.org>
References: <20251020023207.177809-1-longman@redhat.com>
 <20251020023207.177809-2-longman@redhat.com>
 <57cf1fbe-8356-4c5d-864a-20b07d63de72@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57cf1fbe-8356-4c5d-864a-20b07d63de72@huaweicloud.com>

On Mon, Oct 20, 2025 at 02:57:38PM +0800, Chen Ridong wrote:
> LGTM

Can you please use either Acked-by or Reviewed-by in the future?

Thanks.

-- 
tejun

