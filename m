Return-Path: <cgroups+bounces-12756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D1CDEF98
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 21:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 782EF300A365
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3827510B;
	Fri, 26 Dec 2025 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/A1yM6I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+LGKUwe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437C26ED46
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766780679; cv=none; b=tC7TNJFzWf/8f6ZvnTBFCOt1z9Fo9B3tKlXKDRPxlDbt5yLhZlOXsUrjDx4W0qAlM9lU9Rpi2YrzVnT781yec6I3vKA4ktYjYNs8205pdljDdJcuJcM/nfiteXRA/ELn+oHuzPmkzLoHq1jTw8GTka35ePWN/WuAZuCWitwgoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766780679; c=relaxed/simple;
	bh=jhZA2BZKYfB0z3Wiq4o/HOXfT44Mxfr52v44lhVhAWg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MCSek+s747qbX6jk4PZzk9DZTHwkCVkAMwuFYR7j+oRzy7XxMI9fA3c68qp/EebI9ke+d1r6m7RTm8XSJs0OhVkCLfyqVxbDPMEokXcu5rmPpTKYCwPaUMNKH4NJQCB55gMG69lsfzvnQLV0D+0WVN9e6mYQhprdw40stZB//yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/A1yM6I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+LGKUwe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766780675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVoo0z1EjeMhpmoJpAmiOascZOJ5Tgl2Hkp1d1X4DT8=;
	b=b/A1yM6IW0q3KAiEbvoU/HTQPaxD8/GQ/NXxTJwDyLTvNOmvcHXd/gQzaLywqxA91DW25K
	nWL3ImHgY4EDEVhRLyOlPYM5b5OBmY6Srqk3GGN3yQFestQYElMGeuNFu1ewnGmThQGsWo
	VWScAIgTlCj8YD4qjJT5Hd3/OpdicdY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-zgunPk5ROa2NT0vwm4aJYw-1; Fri, 26 Dec 2025 15:24:34 -0500
X-MC-Unique: zgunPk5ROa2NT0vwm4aJYw-1
X-Mimecast-MFC-AGG-ID: zgunPk5ROa2NT0vwm4aJYw_1766780674
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b6963d1624so1800243685a.0
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766780673; x=1767385473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YVoo0z1EjeMhpmoJpAmiOascZOJ5Tgl2Hkp1d1X4DT8=;
        b=A+LGKUweJfR2TmpniwEKY0YePVL2E0SxjmYghrXTSIxpmxbQ49c9tZl3hGk5m61aPa
         d9nagvEsKjFX5Fw53baSvpxUI5sEThd/SQRW5Q3llRkGLzZTMbrNH2Ja5SFdD0G/riSq
         5b6ZCWwKqYkXVsBG/HltYrv/84FxHGznzcJJJi5zYRCDxtIkjIdvBOMHT+5mmzmkaswA
         P/hy9WSnV7Y1RT4o1xL07Vf2pavGOTI1/5YECqNlhMxsRYlj1jcYBwNrIL9abD12ApRx
         cT7aPV6pO+fjjnJhQVENgOpMueVXpVzO1gF06gXvrQxi/tst7QcgL2+D5YesSgzwspve
         xzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766780673; x=1767385473;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVoo0z1EjeMhpmoJpAmiOascZOJ5Tgl2Hkp1d1X4DT8=;
        b=NfkwhP0rKsKaelwHKPn9pmF8bLPh44V7fPKYqiAGdCxh/UcZVp1SGHsD8RrTRDAiO1
         QXhmE1vOSx69Gc/42vt9OThWuH0YsJrrkrZgIuz9qGa5YwNTzPg/bjZQbir+gUOBhBmv
         GJEDmfarg9GUA+sZUF4F5LrsttGbf6Y8SszCsZ/fM78U6+2JZJevfsxmXITPHmfHtAJo
         aSBdzsUjtKQ8SxObJm28F/G9ODHMmXiZtOu4uGbpWN4zSei+iLV+ShEtxvKzM8eK5RTj
         K9jk+MUVOsoxhJL8aBQKq6Iv9JgROKr0xHy9APt2GZOVoZdrQ+w6PRDWPLPhDMGcWlwY
         KS/A==
X-Forwarded-Encrypted: i=1; AJvYcCWbenzOY2rRGsdoBmzU6jScm6iaYpU12NVcEaVUL09SWu6hZRGlTDGB6JW7QidpsHKDTK8J1m3x@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrb9mXd4p28sHpejVqooZoqeeRDUmpDNaJ+lywBFosPhJMoV9M
	0njsQWjkHqPYEnF+m8eOzY/lYzDspaQwjTvOG3sqExRZu6vPBv2lPLwpe1HduDqMnufJ4geZxAk
	XHmWS3akT4griRFc+ba/6U87h+YGGsyVUF7Dkcb7TOPMDJAhtuIbnQvnYAPxjmFEViv4=
X-Gm-Gg: AY/fxX408yjFEeT60cKl2i3a/W0XxJMwVX2a3m+TOzG+X15M4YqTLj7vuU+qUO1+9Q4
	05fW8GtJqVG8XtpF8xcMBPfJeM8Z/x7dohuCJYg85zQ5URTkmJqMTFEs98LXZcejxbnCFMxW+vM
	of0e5Ov5nr5hHWLpQ8dp1n71iv5B37JDLTo12vQyDpkW2e1gsKZMHa5nKMsYfVXPI/IUVOfa0Cj
	SsyeevOQWSpIB3wguY3VDABTlxejYlcL0YFw9xfWf1afm/8DfaM4OcDw5jZzPfqVWmeu7ovPB2n
	G5p3fr50SAH/fpGlI/Wh6vMQufHnH06wMl07VLHlGk6JnU52lBh46U7zPl7aB0tW4UD6dxsOwiy
	OspeYii2JhLwg+LuPfwZG6dyg2+HznHv30WVvcLF6GAllCRtoK9bD36Rv
X-Received: by 2002:a05:620a:454d:b0:8b2:63ed:dd10 with SMTP id af79cd13be357-8c08fbc55a8mr3698251585a.78.1766780673515;
        Fri, 26 Dec 2025 12:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhqIf/jULtsdNL08BWEMGPL/DvVfrN+61SrOaEkqG9ajbsq4/twwSZpVmwA+gRdm04CGZ7hg==
X-Received: by 2002:a05:620a:454d:b0:8b2:63ed:dd10 with SMTP id af79cd13be357-8c08fbc55a8mr3698248685a.78.1766780673098;
        Fri, 26 Dec 2025 12:24:33 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f8572sm1742247785a.25.2025.12.26.12.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 12:24:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <84ed9b5d-41d5-44a1-a1ad-2b3de8b50a50@redhat.com>
Date: Fri, 26 Dec 2025 15:24:29 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
To: Bing Jiao <bingjiao@google.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gourry@gourry.net, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tj@kernel.org, mkoutny@suse.com, david@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 axelrasmussen@google.com, chenridong@huaweicloud.com, yuanchu@google.com,
 weixugc@google.com, cgroups@vger.kernel.org
References: <20251221233635.3761887-1-bingjiao@google.com>
 <20251223212032.665731-1-bingjiao@google.com>
Content-Language: en-US
In-Reply-To: <20251223212032.665731-1-bingjiao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/25 4:19 PM, Bing Jiao wrote:
> Fix two bugs in demote_folio_list() and can_demote() due to incorrect
> demotion target checks in reclaim/demotion.
>
> Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> introduces the cpuset.mems_effective check and applies it to
> can_demote(). However:
>
>    1. It does not apply this check in demote_folio_list(), which leads
>       to situations where pages are demoted to nodes that are
>       explicitly excluded from the task's cpuset.mems.
>
>    2. It checks only the nodes in the immediate next demotion hierarchy
>       and does not check all allowed demotion targets in can_demote().
>       This can cause pages to never be demoted if the nodes in the next
>       demotion hierarchy are not set in mems_effective.
>
> These bugs break resource isolation provided by cpuset.mems.
> This is visible from userspace because pages can either fail to be
> demoted entirely or are demoted to nodes that are not allowed
> in multi-tier memory systems.
>
> To address these bugs, update cpuset_node_allowed() and
> mem_cgroup_node_allowed() to return effective_mems, allowing directly
> logic-and operation against demotion targets. Also update can_demote()
> and demote_folio_list() accordingly.
>
> Reproduct Bug 1:
>    Assume a system with 4 nodes, where nodes 0-1 are top-tier and
>    nodes 2-3 are far-tier memory. All nodes have equal capacity.
>
>    Test script:
>      echo 1 > /sys/kernel/mm/numa/demotion_enabled
>      mkdir /sys/fs/cgroup/test
>      echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>      echo "0-2" > /sys/fs/cgroup/test/cpuset.mems
>      echo $$ > /sys/fs/cgroup/test/cgroup.procs
>      swapoff -a
>      # Expectation: Should respect node 0-2 limit.
>      # Observation: Node 3 shows significant allocation (MemFree drops)
>      stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1
>
> Reproduct Bug 2:
>    Assume a system with 6 nodes, where nodes 0-2 are top-tier,
>    node 3 is a far-tier node, and nodes 4-5 are the farthest-tier nodes.
>    All nodes have equal capacity.
>
>    Test script:
>      echo 1 > /sys/kernel/mm/numa/demotion_enabled
>      mkdir /sys/fs/cgroup/test
>      echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>      echo "0-2,4-5" > /sys/fs/cgroup/test/cpuset.mems
>      echo $$ > /sys/fs/cgroup/test/cgroup.procs
>      swapoff -a
>      # Expectation: Pages are demoted to Nodes 4-5
>      # Observation: No pages are demoted before oom.
>      stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1,2
>
> Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bing Jiao <bingjiao@google.com>
> ---
>   include/linux/cpuset.h     |  6 +++---
>   include/linux/memcontrol.h |  6 +++---
>   kernel/cgroup/cpuset.c     | 16 ++++++++--------
>   mm/memcontrol.c            |  6 ++++--
>   mm/vmscan.c                | 35 +++++++++++++++++++++++------------
>   5 files changed, 41 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index a98d3330385c..eb358c3aa9c0 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -174,7 +174,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>   	task_unlock(current);
>   }
>
> -extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
> +extern nodemask_t cpuset_node_get_allowed(struct cgroup *cgroup);
>   #else /* !CONFIG_CPUSETS */
>
>   static inline bool cpusets_enabled(void) { return false; }
> @@ -301,9 +301,9 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>   	return false;
>   }
>
> -static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +static inline nodemask_t cpuset_node_get_allowed(struct cgroup *cgroup)
>   {
> -	return true;
> +	return node_possible_map;
>   }

The nodemask_t type can be large depending on the setting of 
CONFIG_NODES_SHIFT. Passing a large data structure on stack may not be a 
good idea. You can return a pointer to nodemask_t instead. In that case, 
you will have a add a "const" qualifier to the return type to make sure 
that the node mask won't get accidentally modified. Alternatively, you 
can pass a nodemask_t pointer as an output parameter and copy out the 
nodemask_t data.

The name "cpuset_node_get_allowed" doesn't fit the cpuset naming 
convention. There is a "cpuset_mems_allowed(struct task_struct *)" to 
return "mems_allowed" of a task. This new helper is for returning the 
mems_allowed defined in the cpuset. Perhaps we could just use 
"cpuset_nodes_allowed(struct cgroup *)".

Cheers,
Longman


