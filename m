Return-Path: <cgroups+bounces-844-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E73806629
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 05:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66ED21C21006
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 04:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090E7FC01;
	Wed,  6 Dec 2023 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jj5b84Iq"
X-Original-To: cgroups@vger.kernel.org
X-Greylist: delayed 497 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 20:25:31 PST
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63ED3
	for <cgroups@vger.kernel.org>; Tue,  5 Dec 2023 20:25:31 -0800 (PST)
Message-ID: <8cf7c66b-9e74-4365-b4dc-20c54212707d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701836232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iD1DeFj49lTVT57ImfDP6OVRtCRqS0tdV1f6StpPD6E=;
	b=jj5b84Iq8881uzQLLwWbYMFoUcKkzyuFOBGYypyn3o5TtkGkfAIKLNcRaEc2Jz9uxYcAzm
	Exz39hcG6nkPMbTx6JX4ddAGnvekx0xIYS4cW414RqDGLZROl90uULDSm1MrokVF73rjId
	S7uORlSQdNCZHwvXbuhqf2ASyOvxJhM=
Date: Tue, 5 Dec 2023 20:17:04 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/3] bpf: Enable bpf_cgrp_storage for cgroup1
 non-attach case
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
 jolsa@kernel.org, tj@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org
References: <20231205143725.4224-1-laoar.shao@gmail.com>
 <20231205143725.4224-2-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231205143725.4224-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/5/23 9:37 AM, Yafang Shao wrote:
> In the current cgroup1 environment, associating operations between a cgroup
> and applications in a BPF program requires storing a mapping of cgroup_id
> to application either in a hash map or maintaining it in userspace.
> However, by enabling bpf_cgrp_storage for cgroup1, it becomes possible to
> conveniently store application-specific information in cgroup-local storage
> and utilize it within BPF programs. Furthermore, enabling this feature for
> cgroup1 involves minor modifications for the non-attach case, streamlining
> the process.
>
> However, when it comes to enabling this functionality for the cgroup1
> attach case, it presents challenges. Therefore, the decision is to focus on
> enabling it solely for the cgroup1 non-attach case at present. If
> attempting to attach to a cgroup1 fd, the operation will simply fail with
> the error code -EBADF.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


