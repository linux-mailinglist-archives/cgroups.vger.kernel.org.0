Return-Path: <cgroups+bounces-6077-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A5A06A76
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 02:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D74F3A4FD0
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D611BF37;
	Thu,  9 Jan 2025 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3Iit4hb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FE4A1A;
	Thu,  9 Jan 2025 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736387748; cv=none; b=sb5W8RVWSSWY4GnqDcInuWCqcvDXyw4vkplgkqPP+q6H2p/lKgLYPX3xuiPhs3I0Nx3xj0/aSZkOJSdP+36mhSG6Rr1eEyPZsRKJcXliH7/pokjt6xosZ+QpPHWGz8hNAmAZChT1TlOltEfk1yKM+ihake14ls5gUH2AcWojspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736387748; c=relaxed/simple;
	bh=wIIHCAdo+BNn2/xX5nozLXuFjnGTaZHYkTnV32H6hkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab1EnLNFQg1PASriy0fxMyJ/KCDWikml4YQaIjYvX/GXJNwOCRuPLOUajo9xaRv0SOtC8B0i3aiax9RrFYzYbpvcyOsDPiSxd4JxnEH6u9rEfruSnXB2xZFIy/zeVg9dRmBUT6gUuGlTBWcsBcmIYwtGKN7yQvpWOOw1JpAqfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3Iit4hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1011C4CED3;
	Thu,  9 Jan 2025 01:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736387748;
	bh=wIIHCAdo+BNn2/xX5nozLXuFjnGTaZHYkTnV32H6hkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3Iit4hbQGqjFqJhti3BDvwygYHHUOUDSseK8MqjkohVmR7+MUfaznC54+MQii9S1
	 6XXuFBEI5EI6hOUoSiyWQAOCEnsVPxDd3Ua/DA1cyjTUxUsUGSF53PYo4JnpMpGGXb
	 pVyN4vQ7zc58YCY9sYLBxFUtwJCRqq72g9EmB3eci+sZdjYNjKu6wKjncEPkA6uJMS
	 Ki3OLx32g6e+JRvgFwp/OYbHTecOrKDCExVF1P5vW6MkCLOoQIRQCpw8hNlPB7hbri
	 qiogpVEWZIISZY23IuENtSuWhJMBHxS3MrMB7ouAOSBP128YUQ7MDtWNy/i0muxpU2
	 kD+xpS2ZficFg==
Date: Wed, 8 Jan 2025 15:55:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Waiman Long <longman@redhat.com>, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
Message-ID: <Z38sopf57DAusY9I@slm.duckdns.org>
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
 <Z37Qxd79eLqzYpZU@slm.duckdns.org>
 <9250b4e8-8ef8-4a85-af24-14a34cc72e3b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9250b4e8-8ef8-4a85-af24-14a34cc72e3b@huaweicloud.com>

On Thu, Jan 09, 2025 at 09:29:59AM +0800, Chen Ridong wrote:
> Hi, Tj and Longman, I am sorry, the fix tag is not exactly right. I just
> failed to reproduce this issue at the version 5.10, and I found this
> warning was added with the commit bdb2fd7fc56e ("kernfs: Skip
> kernfs_drain_open_files() more aggressively"), which is at version 6.1.
> I believe it should both fix  bdb2fd7fc56e ("kernfs: Skip
> kernfs_drain_open_files() more aggressively") and 76bb5ab8f6e3 ("cpuset:
> break kernfs active protection in cpuset_write_resmask()"). Should I
> resend a new patch?

No worries. I updated the commit in place.

Thanks.

-- 
tejun

