Return-Path: <cgroups+bounces-13768-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uq8nJ7+Zh2n3aQQAu9opvQ
	(envelope-from <cgroups+bounces-13768-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 20:59:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E510701C
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 20:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9952A3010BA9
	for <lists+cgroups@lfdr.de>; Sat,  7 Feb 2026 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346DC33A9E1;
	Sat,  7 Feb 2026 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/GWVAlI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C32FFDFA
	for <cgroups@vger.kernel.org>; Sat,  7 Feb 2026 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494396; cv=none; b=bbqbYl58skvBYmry0g/emgquYDqaHuamfWBhRHhQNMDuFXIKNgGUOxMGH3vAItiUDeqoG/2n24YtWjy1ciKhTu0TCu4ySeP7sm9JVyP5xi/lNBrZXIvoSVspOcUFWCyYOZzkfQWnV6s6uGnkvKYWsvAZIJMiwRmzjcf2/wC4h80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494396; c=relaxed/simple;
	bh=+Xr8rYTGybFifeFwE8v5Ha3sigxdFru5hwVghREHhjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcQVw8wnXfHsNyqCvewJTKh2cckLsrk8Oa6r3ysrN4CM0OQ1JemiJbI5wASS4ITTWmRYgVTiuAaAX0LCh0exVyNsduufsxEu/73gygd7Bly1NS7hbxHvcfasJQlEektp5z+0itQP63Dum3SxEj+V4hg/JPyyL0XOvLj4bEN/bMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/GWVAlI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso32952815e9.2
        for <cgroups@vger.kernel.org>; Sat, 07 Feb 2026 11:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770494394; x=1771099194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OXJ4VqhuGT/CfXgMjy4IV1o4Ev+iXuopy/eJZiNHX4=;
        b=L/GWVAlI9NWBUh/GGRrUPo+0uccBexf9259PkTtDRtzlAXx0oP32KkrL8TaCaHkgWr
         AClBOtuWtT+TMk5BHVeIwN+bQHxJoIhFYmkWAK+8kcZvLDKNw8zCy8SGNMjU1DMb2hB7
         QmZqKwX4o9AHnIfWu0GzqbHGULnQw61t+3MaStuAByYEOlZbhFBubVFzqf3IG8uOZRPd
         GH27tO5iSR5eYxsBFvorqhAgW8+YMmOPKPv+PjModA0lxrVQl5aJYOs9pwt+q7I2tEO8
         jELJ+JsRCZrhHJI3u2eZThlyWdt0PHbpDaxZb2YATeTUqfSMgxxyNj2tgizLCwmFYpZt
         bXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770494394; x=1771099194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OXJ4VqhuGT/CfXgMjy4IV1o4Ev+iXuopy/eJZiNHX4=;
        b=kVwf9QYyzBN22B7kMkwugVi81Z8LwVvU/kw4qeQUfZuB0Jj+45gIAr0qGVXndC3goy
         AQhhQxDaC9Dx9Ppz5baNfjlp3NhEVyi59LJ296NWQDNDWDX4+zmcTAX1Dn4vXdqw3zAp
         swFZpW5DVmAaDtCRB3YMLv8o/tCxVmiw0SGjh7nHQHtN3mEO0AkpafJmnZ1/+XRbxEMN
         9YhU1wr5hmW83R15YAHBIzoIExmvCwqvDD6wSUx5YybCwHM/Z+VCBL/eZxnJQqXbsGyf
         OPWseFuQ10JcphQK2p+3+/pZX2cL898WcTVV++cgWWxbzLgmxnxtS+/q0aqAmKDF/e2e
         yjYg==
X-Forwarded-Encrypted: i=1; AJvYcCXAA5H1KLnzKhU7h+UklLTeMmuvoBf9XciF5zylbIZqgwpE4SGFYNqT/Xz9zMBw3/6pkVjOzYct@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJwPxqXd//SouFKAksfiePSxbsfy7f+aclE4OVnCqCTqGJtPE
	+ie+TZEWMmh71tvILoN3bvUe83JjpwEXgRNluTUAdbM7YO/wgDtZXX/J
X-Gm-Gg: AZuq6aJn/9VSCX1sizolLbFw2ObvF+it9PWC/X9BxWKDhgVTJyBvor+XAonzmiuZFP7
	ydl+JCza+flX4si89Cs12P7+KPVlVMR328nUgaD4c/U0DIPfUEm9LzyUFVsxWJFVxLu2Yil4C6u
	H1Rj2pTbKAUNH6yaaaHcQd+CPaYtZuxqxM/UHrnGbVaLPqq9onMcLbgVjIK+R807gBfNe9Z1WRz
	ZAx2bJigSguPLfnRPr8v2vZWQBYzCHDazYR1SczRxPW9AqJWsJ46RHCtbPQGds5OXycBbjS5U22
	y8cSGuhb5ZGdxb1R1r1JJz3sSYiLIlk2vFVTunLJnyjDYlNbzXjMhusZ5LNCRIKWu1SWlbBT7qV
	j8dAAAZiXgnkQWtM1QUWOjUK//qrti8xEDXXLljk/Pz501J0hwMzNPNg1ybBKdGrfE+lrimzETb
	86nClXKjPmuRGh/f3Qqngoav2o08XUccibm57/emEc9pOt7WayYW6hT2eetXSUTHSYu7O2mY2cj
	Qw1XYee9QhPmqI=
X-Received: by 2002:a05:600c:4fc8:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483201dc396mr100885895e9.4.1770494393810;
        Sat, 07 Feb 2026 11:59:53 -0800 (PST)
Received: from ?IPV6:2a02:6b6f:e752:9400:18cf:c773:ee86:c436? ([2a02:6b6f:e752:9400:18cf:c773:ee86:c436])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320719b8fsm143031285e9.9.2026.02.07.11.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 11:59:52 -0800 (PST)
Message-ID: <c921485b-bccc-40b6-b2c7-5163739de9d9@gmail.com>
Date: Sat, 7 Feb 2026 19:59:51 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/31] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
Content-Language: en-GB
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
 <9e332cc8436b6092dd6ef9c2d5f69072bb38eaf6.1770279888.git.zhengqi.arch@bytedance.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <9e332cc8436b6092dd6ef9c2d5f69072bb38eaf6.1770279888.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13768-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usamaarif642@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B0E510701C
X-Rspamd-Action: no action


> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e7d4e4ff411b6..0e0efaa511d3d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -247,11 +247,25 @@ static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgr
>  
>  static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>  {
> +	int nid, nest = 0;
> +
>  	spin_lock_irq(&objcg_lock);
> +	for_each_node(nid) {
> +		spin_lock_nested(&mem_cgroup_lruvec(memcg,
> +				 NODE_DATA(nid))->lru_lock, nest++);
> +		spin_lock_nested(&mem_cgroup_lruvec(parent,
> +				 NODE_DATA(nid))->lru_lock, nest++);
> +	}
>  }
>  

mWould this break lockdep on more than 4 NUMA nodes as MAX_LOCKDEP_SUBCLASSES = 8 and
2 locks are being acquired per node.

>  static inline void reparent_unlocks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>  {
> +	int nid;
> +
> +	for_each_node(nid) {
> +		spin_unlock(&mem_cgroup_lruvec(parent, NODE_DATA(nid))->lru_lock);
> +		spin_unlock(&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->lru_lock);
> +	}
>  	spin_unlock_irq(&objcg_lock);
>  }

