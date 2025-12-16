Return-Path: <cgroups+bounces-12381-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7154CC4F8E
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 20:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BDBB302A752
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76E2E7165;
	Tue, 16 Dec 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7MCbrBm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C486359;
	Tue, 16 Dec 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765912026; cv=none; b=jQWmkivsXzwqZZIxT4KkSSjYD9wdppFE+Yjb+79yZ+Lsj6CTmiygFZx4FskBOVfrwYXv4WQ87D/1QaNe0R3rZZ46w869hYoV3PGcKD7koyOtQkQmxc+FvLPpxHFjAd8soycNekpEo7IIuTnl3LFxwcFMiuWquOhMC0e6pKPo7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765912026; c=relaxed/simple;
	bh=1xWcQjK1WzkS7YnW7fIuJybbX59eIvr9KKxXVxlTaWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrsJnqEpJqpKEb4lukD5thbvP3/uFSeIn75AV2ExExi2c4uXJNwREfJ/o2UHtxKIeqXpdqDmBabI8uO1ciLaLN2CMEEotfKi3exA5GRo0e+Sk+6bKF2tmGAS+ku4BojeWlRIL7YLPVWhQrdLSA04xMZn8MXeo7vDFvpgMVQWH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7MCbrBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08428C4CEF1;
	Tue, 16 Dec 2025 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765912026;
	bh=1xWcQjK1WzkS7YnW7fIuJybbX59eIvr9KKxXVxlTaWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7MCbrBma6J400qDKvciB3eCJGQSwVf6bEw/yJNc8dUgqOlDC4xAkMOVsuNoq6go9
	 RHeUtCjh0dNI/FRgBOpaUdCnA9Xf1KUbu/PPUTajzzSwvU4d2eK4lt+uQj8poOHkLx
	 /NzzHv6NVLBVJl79eIU4jLExdhFz0VPiAsqdg5hcZ4saGfs98R1WgGVMRxNiLmQ83m
	 SMQUmME0mQPcAPbBXp/jLn5VG4myNQSM3Eis+zas+R9SOrQoHrsCzhr9ClGj/xGOzz
	 zjD3VI+DCFNKDTSUEoFlngALJQ5KF542VHJKhslorL2uQwYbOkjRmdWAyJrPg2KEMC
	 Rxey/RkT0T9Kw==
Date: Tue, 16 Dec 2025 09:07:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next] cpuset: fix warning when disabling remote partition
Message-ID: <aUGt2UMveTAhs1yX@slm.duckdns.org>
References: <20251127030450.1611804-1-chenridong@huaweicloud.com>
 <d43bc75d-0a5f-41e7-b127-df6c3d26f44b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43bc75d-0a5f-41e7-b127-df6c3d26f44b@huaweicloud.com>

On Tue, Dec 09, 2025 at 10:56:20AM +0800, Chen Ridong wrote:
> Friendly ping.

Waiman?

Thanks.

-- 
tejun

