Return-Path: <cgroups+bounces-3813-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64550937AEC
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC6B281763
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E7B145B32;
	Fri, 19 Jul 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="04V5Qjiw"
X-Original-To: cgroups@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085382AF12;
	Fri, 19 Jul 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406398; cv=none; b=msdbxgQAFW+Ge2txGm4H8UnWPxr1aeqUQtHkr7d/UGgdomhawGDrjhjFN9i6M8trFVNFOGZCmapoWQfXGdK3JSuvBzQ91qskdGEAYTGiwJjKA97SEVgxovpOyA20Ts+wJadsEph/MJPf1AY7z7AsynsctueCjQt4Op6KGGatQmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406398; c=relaxed/simple;
	bh=Rt/4V/xhH2exTCttg81dlqMp12KALqaZMLr7+iVua1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMDYv6NkG8n37ouAsgh0V/FVI2GPsCqZ/26uN0ASkKU7gN3+J35i5aFNUsQTCleQDL7GLGCKs6hI4dqzgNn8Z1JVV7/n51zf2ZO3MivUWAVmyXs45miqDAG3fCqB1Z5pDbwNB/1WYH9dI4cafiemszr5h1zIIogR0UtshyhCD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=04V5Qjiw; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WQZn83v1Vz6CmM6c;
	Fri, 19 Jul 2024 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721406392; x=1723998393; bh=Rt/4V/xhH2exTCttg81dlqMp
	12KALqaZMLr7+iVua1I=; b=04V5QjiwXtG3nDX9b2m7yOMb7UgWIcmvxHuNS8bE
	DjDHmabz3K/YzgB87qb4TYiOuFCq4NuHJGdKRnZq0+XHiyXINGXPKiSilsa7Wlpl
	3kB0xMi6uMND/zaxCA87YDxTMox3K9GzPh+i5AIZsruWpIXcj2W5qpIPBuBDM7nd
	Ik/MCLlSEVsN9xuQ4Nuo1jPKGJjzaxKe21jRcbGzg4eLFL/QvOtOMEUcf/BGy2P0
	sJC8/T5fqbq1+oFLjz0+BzsZzmu9Udh7rDJNjtTr7T2ghM50Vnw/5aGUpDY2Ehkn
	wUoTjDs/LA+alwSWtjDDdD9UbjZOYEPQQSA4bVbLux5QsA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BnuVG_Tg1L05; Fri, 19 Jul 2024 16:26:32 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WQZn15BnPz6CmQwQ;
	Fri, 19 Jul 2024 16:26:29 +0000 (UTC)
Message-ID: <38a63742-99de-47c2-a91d-ede30a4ccd8b@acm.org>
Date: Fri, 19 Jul 2024 09:26:27 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] blk-ioprio: remove per-disk structure
To: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@infradead.org,
 tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
 <20240719023431.3800647-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240719023431.3800647-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 7:34 PM, Yu Kuai wrote:
> ioprio works on the blk-cgroup level, all disks in the same cgroup
> are the same, and the struct ioprio_blkg doesn't have anything in it.
> Hence register the policy is enough, because cpd_alloc/free_fn will
> be handled for each blk-cgroup, and there is no need to activate the
> policy for disk. Hence remove blk_ioprio_init/exit and
> ioprio_alloc/free_pd.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

