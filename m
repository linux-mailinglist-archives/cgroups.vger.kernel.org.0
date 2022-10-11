Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586A25FB87C
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 18:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJKQqq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 12:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJKQqk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 12:46:40 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C174A572E;
        Tue, 11 Oct 2022 09:46:34 -0700 (PDT)
Message-ID: <2ba0ee79-2e7e-6807-3312-1a2c5ef3bae0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665506792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSpHFQ/t+wVXLc+3hNEAK/z5TCpUZCMKJcQhLnBO7pA=;
        b=VZXczMB1/0cXDlJrV4Hl9sjqWKt4jiyPljBV9WZxUvzdbwjoKUqh1lDfvqbGk8Z/cPGbuU
        VrlszEalWaKYs9+1ekJ60k4dB7wYy6bqb7n9IIKJ3baP+C7ioDlkDKwAQWkwmQEmMU0mZB
        JamUEiyRsoy6dCO7N4Vlwh+lNYYHkwM=
Date:   Tue, 11 Oct 2022 09:46:27 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] bpf: cgroup_iter: support cgroup1 using cgroup fd
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221011003359.3475263-1-yosryahmed@google.com>
 <20221011003359.3475263-3-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221011003359.3475263-3-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/10/22 5:33 PM, Yosry Ahmed wrote:
> Use cgroup_v1v2_get_from_fd() in cgroup_iter to support attaching to
> both cgroup v1 and v2 using fds.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>   kernel/bpf/cgroup_iter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> index 0d200a993489..9fcf09f2ef00 100644
> --- a/kernel/bpf/cgroup_iter.c
> +++ b/kernel/bpf/cgroup_iter.c
> @@ -196,7 +196,7 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
>   		return -EINVAL;
>   
>   	if (fd)
> -		cgrp = cgroup_get_from_fd(fd);
> +		cgrp = cgroup_v1v2_get_from_fd(fd);

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Tejun, patch 1 should depend on a recent revert that is not in the bpf tree yet. 
  Do you want to take this set to the cgroup tree?

>   	else if (id)
>   		cgrp = cgroup_get_from_id(id);
>   	else /* walk the entire hierarchy by default. */

