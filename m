Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8BF55CC04
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbiF1DnL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 23:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiF1DnK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 23:43:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED84261A
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 20:43:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i18so20010205lfu.8
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 20:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wqQTvy4npFnWvHaeytKvLIfMhrlsDZms9Ty/8zJvQjs=;
        b=64xD/V4SyUPW+r9Dv8phb4pTH4m0bCeeUz5aipfYF7c5UGDNkGiFBmg+C6z8y1Hrbr
         du+px0oVBuZ+uX02mYW+Dl6Jh+fxDHKqQXmWUZuXy2ryeQYSYs8FrRD+CZO8wraGqO5n
         7IySqR1dCXsHmRt7gxHDWXK3RhgffiSFFMrHh/x+6cKqmtYcFZ4ratxoXAJe3J9S4wnr
         yJEqZci8S9QMvNexA/TvkWJANj800nAn8LlQs7d/hAYl3U4FjbLBZajINip30oMR4JsW
         Lrf9MYDoTwmpGxE+th98A5tqW14W5oXwHrcqbD9TIoMuyiaK7dCFbUpHU7GEMPWMjVpZ
         vStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wqQTvy4npFnWvHaeytKvLIfMhrlsDZms9Ty/8zJvQjs=;
        b=LC+rHJFySvBpHiB9VogsyUIkqth2IHG0tOrC4cnLImxYY5EHUHdvsVcrO2g3meF+HJ
         s9u7pgqi0U1ZYuaty1n9TrKy0rIOUbalqicgjptUBpjyY2/KBl5g/2tMn4DFwK2Jb0wA
         Y/W4og1VAFipYa6E49jjVpwGQKGWkktjiUXwqgV9BoNebMVzgZmTzicGt1Wg+2XA4q9D
         D4z3VdJlZjdY5oX87zmCtTRNNAs4k1j0emAdVCV8Aw4NsNGOLUhUFZqGgRcVv1qdx1nu
         c3/ImwhpCe4ZScxc1FspfomykqeMlTRQrOwzt9UH1Ek7byqo3E4UmX9xKgLIRfm/hGmy
         0j1A==
X-Gm-Message-State: AJIora/GUTmwv2oYf4ytEEmsgMW50Hk4/OYDcXRqOnTobYzJu9bf8JhD
        DaOWt4pWq3+2vZVw8xbLHMvabA==
X-Google-Smtp-Source: AGRyM1uClJxQRttLZzkyeEI9s/FAeEu5A4OnJvh/ak//r13c+AlqjSUMcfZ222BEJVd6tRcw50JWvQ==
X-Received: by 2002:a19:7917:0:b0:481:e0c:29fd with SMTP id u23-20020a197917000000b004810e0c29fdmr8139579lfc.350.1656387784592;
        Mon, 27 Jun 2022 20:43:04 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id o19-20020ac24e93000000b0047f8cb94004sm2038474lfr.35.2022.06.27.20.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 20:43:04 -0700 (PDT)
Message-ID: <e93596ef-d4eb-5fcb-744c-9ef99cb5a69e@openvz.org>
Date:   Tue, 28 Jun 2022 06:43:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH mm v2] memcg: notify about global mem_cgroup_id space
 depletion
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>
References: <Yre8tNUY8vBrO0yl@castle>
 <97bed1fd-f230-c2ea-1cb6-8230825a9a64@openvz.org>
 <CAMZfGtWQEFmyuDngPfg59D-+b9sf58m9qhGoVPSQ_jAGmgT+sg@mail.gmail.com>
 <f3e4059c-69ea-eccd-a22f-9f6c6780f33a@openvz.org> <YrpVP6rpYGFsl3jj@castle>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YrpVP6rpYGFsl3jj@castle>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/28/22 04:11, Roman Gushchin wrote:
> On Mon, Jun 27, 2022 at 09:49:18AM +0300, Vasily Averin wrote:
>> On 6/27/22 06:23, Muchun Song wrote:
>>> If the caller can know -ENOSPC is returned by mkdir(), then I
>>> think the user (perhaps systemd) is the best place to throw out the
>>> error message instead of in the kernel log. Right?
>>
>> Such an incident may occur inside the container.
>> OpenVZ nodes can host 300-400 containers, and the host admin cannot
>> monitor guest logs. the dmesg message is necessary to inform the host
>> owner that the global limit has been reached, otherwise he can
>> continue to believe that there are no problems on the node.
> 
> Why this is happening? It's hard to believe someone really needs that
> many cgroups. Is this when somebody fails to delete old cgroups?

I do not have direct claims that some node really reached this limit,
however I saw crashdumps with 30000+ cgroups.

Theoretically OpenVz/LXC nodes can host up to several thousand containers
per node. Practically production nodes with 300-400 containers are a
common thing. I assume that each container can easily use up to 100-200
memory cgroups, and I think this is normal consumption.

Therefore, I believe that 64K limit is quite achievable in real life.
Primary goal of my patch is to confirm this theory.

> I wanted to say that it's better to introduce a memcg event, but then
> I realized it's probably not worth the wasted space. Is this a common
> scenario?
> 
> I think a better approach will be to add a cgroup event (displayed via
> cgroup.events) about reaching the maximum limit of cgroups. E.g.
> cgroups.events::max_nr_reached. Then you can set cgroup.max.descendants
> to some value below memcg_id space size. It's more work, but IMO it's
> a better way to communicate this event. As a bonus, you can easily
> get an idea which cgroup depletes the limit.

For my goal (i.e. just to confirm that 64K limit was reached) this
functionality is too complicated. This confirmation is important because
it should push us to increase the global limit.

However, I think your idea is great, In perspective it helps both OpenVZ
and LXC and possibly Shakeel to understand the real memcg using and set
the proper limit for containers. 

I'm going to prepare such patches, however I'm not sure I'll have enough
time for this task in the near future.

Thank you,
	Vasily Averin
