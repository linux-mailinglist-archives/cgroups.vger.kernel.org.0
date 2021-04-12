Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEA535D0FE
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhDLTY6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 15:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236999AbhDLTY6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 15:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618255479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sanhxa5ocEIGPBDgrv4bLnJCXX7YJObbafoCV8epdlU=;
        b=fPa9YtVv4Jvi1eQfzPlwx9/jc/Y5hZd7Iy/6YgQWr6PevBeVd0o5HgkSjYogSqRkZa6GgF
        YAmfvVXM8kenvQfTU4HaW6lamxyyJsGGJPmHO2xcqTLqBVeaa6TBecrfK52zJOVqqW+JsF
        CDLQzlU8UmKSRzuxNg+ZIanfwdXYd9w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-WPHi5omsNQCEBvpDuSUzlA-1; Mon, 12 Apr 2021 15:24:38 -0400
X-MC-Unique: WPHi5omsNQCEBvpDuSUzlA-1
Received: by mail-qk1-f200.google.com with SMTP id x10so1562021qkm.8
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 12:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sanhxa5ocEIGPBDgrv4bLnJCXX7YJObbafoCV8epdlU=;
        b=ZzWN/TduNxaO6kn0HS73VE1UQiMvys4ACVVzIPESHTlKXvRZypjLAX4DegH413KbQy
         FTAw0oqNvcqVy7Ojlf2hY52/khRy7Et1oHDFLyYqiSjxUrR4tTq/uP0GkmwTm5RtnZot
         u6Mz/07935j64vciGsYZfi1TqUlJQ4TkGBOLtLI3P4PLsiJ2TzvLUQ0AnqZt+jFHwQ6o
         3BAxH0btAdyJyNirtztw9FRzpWwP6acbvPkj5b4uHCAHgEUgv/FYZy+y8SJSzBp14lnJ
         HB6Y4QZ9/7DDIGXMPx+sQ9JoYEtv7LgHgCfGNP1lwf/8/XBxtedPUqNd6YCeWxCW95Qp
         HIbA==
X-Gm-Message-State: AOAM532Xn2pDuq7VC/QR3JcJ79e6IVyC5/cBzc59myL5CjSRZbycUwvz
        h2kWo4Ij0O2UEPf/9pLeOberp0XAkkkiPbXU4MYdLauOk48hAzKhYF7+8HEHmRZwi4LN7ffRND3
        0vfEpnNKPUZQNWZi4YA==
X-Received: by 2002:ac8:744f:: with SMTP id h15mr4553107qtr.45.1618255477533;
        Mon, 12 Apr 2021 12:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypxJ4IHG0spUFGr+zDp4lXxDXYblWKgo86ypm7XV/jlKk/dJt2ZRAKrs03KzxuMIa0UgEhQg==
X-Received: by 2002:ac8:744f:: with SMTP id h15mr4553086qtr.45.1618255477371;
        Mon, 12 Apr 2021 12:24:37 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h14sm8039561qtx.64.2021.04.12.12.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 12:24:36 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/5] mm/memcg: Pass both memcg and lruvec to
 mod_memcg_lruvec_state()
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <20210409231842.8840-2-longman@redhat.com>
 <YHSLp8bTQGovNLTu@carbon.dhcp.thefacebook.com>
Message-ID: <8a188990-325e-bf89-37ae-f0b29481b738@redhat.com>
Date:   Mon, 12 Apr 2021 15:24:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHSLp8bTQGovNLTu@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/12/21 2:04 PM, Roman Gushchin wrote:
> On Fri, Apr 09, 2021 at 07:18:38PM -0400, Waiman Long wrote:
>> The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
>> available. So both of them are now passed to mod_memcg_lruvec_state()
>> and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
>> updated to allow either of the two parameters to be set to null. This
>> makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
>> is null.
> This patch seems to be correct, but it's a bit hard to understand why
> it's required without looking into the rest of the series. Can you, please,
> add a couple of words about it? E.g. we need it to handle stats which do not
> exist on the lruvec level...
>
> Otherwise,
> Acked-by: Roman Gushchin <guro@fb.com>

Good point. Will update the commit log to indicate the change is needed 
for the subsequent patch.

Cheers,
Longman


