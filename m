Return-Path: <cgroups+bounces-8882-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EFDB0E859
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 03:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837586C0889
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 01:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518DB19D88F;
	Wed, 23 Jul 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+zdax3K"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B1A59;
	Wed, 23 Jul 2025 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235739; cv=none; b=aZ1y12igUKWPSVZZmQHT7PnOS36l0+ODQeCMHMYBukoM0s0nMt0VhuN6j4jCFT5EDt1DOQ4JP7uAGcl3MTGLM2J/6LbvMgKtLTlDMIrDDu9W7j+B0q0awF2DSt6Es7G3KbsZFCuVv7xML+AXI+yCfRKgvwdHFfhZZAHa5vRTs/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235739; c=relaxed/simple;
	bh=0Ibjj/zW48hHXJESfbK7QQJtgVZikQYINqPZY1Yh1mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEdrGO9kINdYDLwoBjpbOx9nqpoOy7fub31WtsLfbWg8+tsYJPM4SUPFurhCPR9za80+YWhN5989bDiIZtktOIsFsth2WjzLROX45U1+W4yANMJq1R5cKeK3WrADY3dZrU0N8MD00/7OPmmZNL99D4Np0vWZlkfs/5ofqarztuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+zdax3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE75C4CEEB;
	Wed, 23 Jul 2025 01:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753235738;
	bh=0Ibjj/zW48hHXJESfbK7QQJtgVZikQYINqPZY1Yh1mM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j+zdax3KCjsQi6gri/2vjGWcg6tZpwErE1xl/oQYk/2K3rPgiObZFg+ZTt4fTY4qe
	 /CjSHk2DpXLSxzcTjWIYI8Q+tclUU8v2OAe66EuUoByXTcS00x2ldnxrxFEd9MqUhu
	 RidfeFU6yPG0eZ5PCor7ozESwEY4ShrPl2AQyTlRxP/caCyw35xsx3YB0l8i5wtbjo
	 Dt2c4+Y2FOjGhxZi4rN9SnKkQMtKhjfyDNaBFL6ki9GTYF8VYPvKhzIrW9IY/SX7pI
	 wa+M9xQYMSrNBweXHuKMKTZ4C5NtYQkcA+b+ic8c0fWztD6NqabNG2ibipvuvA8zk3
	 sKibHQ/TIqOLQ==
Message-ID: <4b3a5b7c-40b1-494c-9707-6b7a4d483c23@kernel.org>
Date: Wed, 23 Jul 2025 10:53:09 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] block, bfq: switch to use elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, hare@suse.de, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-4-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250722072431.610354-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 4:24 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Replace the internal spinlock bfqd->lock with the new spinlock in
> elevator_queue. There are no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

