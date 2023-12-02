Return-Path: <cgroups+bounces-774-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2626801AEE
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 06:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58A41F21133
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3173BA37;
	Sat,  2 Dec 2023 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoTmxtPc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13FA119;
	Fri,  1 Dec 2023 21:53:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d0538d9bbcso11361225ad.3;
        Fri, 01 Dec 2023 21:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701496412; x=1702101212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCRPOdv+OSBaDAjSYHQJOdrd35/mwGfAAGpy6ypFu/U=;
        b=WoTmxtPc3xgCzCIFowgk3qBM6Y1NrzIyewMqdY02rogPWp2mBSiE04tVcBABxwFjpH
         H1pni99U6yCrIdKggYuJV4geAepZVtEFZW3zJZaE5+FTOI+B1eve7y7fneFFP/e+sOvH
         yxqTxz8JURt80wXCN1XUF9ERGCk8sJmJh3SSj4ottu3dqbW+6KqugU/Jeo4SuWUjoyGf
         JuRVN1soiiy52F9UQW5Jt3eRSFBRn36culxFFwJStVK8ZOxBbm99IAV9sFhJRTN6wvyi
         PSQX/lzTXlzFpk2DKo1LVGuq89Azz/0Y/e6Zh4srsU4J5xqcfELERYLFDR+izcVbjvjy
         zovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701496412; x=1702101212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCRPOdv+OSBaDAjSYHQJOdrd35/mwGfAAGpy6ypFu/U=;
        b=Da5oNr2F2YumIp8I9UWKnfKAv2ZADu+zJ5Cdx7XIwWdh/8NJR0op9SXVYOQgg+ppVm
         a72KAU6fOxV0EPyaPRMW3feSCpTwbR6nHLgXA/xTQae/IzfXia04GpHDy4NR0Ggz9lwr
         D9EPWdhHlxFl942fHn9E8fN/DIwjt0Y3TCwvOjo5F/93p+vkiIQYWHdwO+h/vvndVCYn
         bqjmlSW2EoZhojVrSIr2nq/V5/LdGxk3yitFXjXUi4cJ/qgExQAHjS6TIuMlZXTowwkv
         8a30ewUY74XivhVgZsz2Bdo2/ppxI8q5yz+4WBtiyqF0bQOQTwJ3+xufVnhyTvvD7C/s
         ZJuQ==
X-Gm-Message-State: AOJu0YxAmbP/kHZvPl9Mk5uhmMKgr9UmP7m9L+5gKHlnaKRpe37jnJ9r
	46zlH6K8S4xeRCVzK/YkOauK6C2w3jUTIg==
X-Google-Smtp-Source: AGHT+IGGj6z2rDhAJOroxjJ73Spkhaw9LeUO+j5FAzbMTsNW53fktbd5lxl+Vi+q76cyep8sG3uh3A==
X-Received: by 2002:a17:903:32c1:b0:1d0:6ffd:e2c8 with SMTP id i1-20020a17090332c100b001d06ffde2c8mr814674plr.98.1701496412419;
        Fri, 01 Dec 2023 21:53:32 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001cfd2c5ae6fsm2627264plb.25.2023.12.01.21.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 21:53:31 -0800 (PST)
Message-ID: <523f0517-fdbf-488b-87d1-f611c97ef810@gmail.com>
Date: Sat, 2 Dec 2023 12:53:24 +0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
Content-Language: en-US
To: Waiman Long <longman@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 kernel-team@cloudflare.com, Wei Xu <weixugc@google.com>,
 Greg Thelen <gthelen@google.com>,
 Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
 Attreyee M <tintinm2017@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux CGroups <cgroups@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <ZWqPBHCXz4nBIQFN@archie.me>
 <436e96d1-29eb-49ec-a463-2ed420757ce8@redhat.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <436e96d1-29eb-49ec-a463-2ed420757ce8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/23 09:56, Waiman Long wrote:
> 
> On 12/1/23 20:57, Bagas Sanjaya wrote:
>>> -void mem_cgroup_flush_stats(void)
>>> +/*
>>> + * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
>>> + * @memcg: root of the subtree to flush
>>> + *
>>> + * Flushing is serialized by the underlying global rstat lock. There is also a
>>> + * minimum amount of work to be done even if there are no stat updates to flush.
>>> + * Hence, we only flush the stats if the updates delta exceeds a threshold. This
>>> + * avoids unnecessary work and contention on the underlying lock.
>>> + */
>> What is global rstat lock?
> 
> It is the cgroup_rstat_lock in kernel/cgroup/rstat.c.
> 

OK, I see that. Thanks!

-- 
An old man doll... just what I always wanted! - Clara


