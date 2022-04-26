Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B855D50F086
	for <lists+cgroups@lfdr.de>; Tue, 26 Apr 2022 07:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiDZGBT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Apr 2022 02:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiDZGBS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Apr 2022 02:01:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A0837A8A
        for <cgroups@vger.kernel.org>; Mon, 25 Apr 2022 22:58:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 4so7001860ljw.11
        for <cgroups@vger.kernel.org>; Mon, 25 Apr 2022 22:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZBYAGN8Bb7OvFzAe7F9Y2LfgGtxk1nTfvTdOaaOXGBo=;
        b=Jq6JdD8VzFEq18+o276NScliYwVuNJf4Rn3tazrd5OBUECXdtwysjbVzisP42H7Zfg
         AzLF13iBPuGB4G8laKbcZXc+vG2Nd6M+Fk6lwgFd3A2z8Y97UPbC0O5FCrHPpHCQfkNj
         LsXD2YsfDHX3vGdtEbPWrIaeng7NCC/JLJLjHxphWsPsxrCBycx7sWesbCjiyTLJkQcU
         FFpPWUdRKmtffIo1OD6Dfll3JGIziSw1stDsXiz0KhtuGy3kd9vpS4CwqwZguWcs3uEG
         CaYqiqwcLSyiA8L314rfaauhH780shmI3tTGilQpxB+MADc1Eq9p/n3OpAQrudz4xvnl
         +1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZBYAGN8Bb7OvFzAe7F9Y2LfgGtxk1nTfvTdOaaOXGBo=;
        b=gASAZ2opzG8F/xOv3xhDWmeyXHJn1AS0oPoF3GQOSpRDVMkxp9y80Qvm2ijCCENc3+
         7Eq2irrkcd1sTvalF8LL3MmNn3bZQP+QQCW4DdAfKsF3eEeieUjdh7BHZvRA4c89Jduq
         KHfjFSDQzYw6s8nD2PrAkAYpYi5SGnlCCSTYZI1Rg2uA5mSxx1J9dtVpkoQFU6HGYMYU
         U4C4Qtzvytpjp6Ju1jFrYw4BmXx+Xota9dpUCLnEu64msit/HpQmnishlNSTnjcHqGb1
         MnXbfzqc1WMWiwn8PDe3CyT+hIQ1VgvbTeFp/1h4wNuOYx8jY4BEs50M2vTxqLhkRrEZ
         /tEQ==
X-Gm-Message-State: AOAM531yE1Y997SMNHBag0OpL52ZIgX+jXuM3hVZE5WjsXge61P0g5YV
        C/Q4l0j5SEe0K/rJpMfZkEToCQ==
X-Google-Smtp-Source: ABdhPJzJ4Y2ZL7hQaKEw+Vte8SinmUwWkmqbez+I5+jcZxArwggXNGYCdD6XBVTwdCo0eoKzKbGNow==
X-Received: by 2002:a2e:8247:0:b0:249:8615:4242 with SMTP id j7-20020a2e8247000000b0024986154242mr13137747ljh.108.1650952689026;
        Mon, 25 Apr 2022 22:58:09 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id t23-20020a199117000000b0047204c620b6sm745653lfd.248.2022.04.25.22.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 22:58:08 -0700 (PDT)
Message-ID: <a153e5da-b22a-2ea5-f0ef-a46337711400@openvz.org>
Date:   Tue, 26 Apr 2022 08:58:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH memcg v3] net: set proper memcg for net_init hooks
 allocations
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20220424144627.GB13403@xsang-OptiPlex-9020>
 <c2f0139a-62e2-5985-34e9-d42faac81960@openvz.org> <YmdeCqi6wmgiSiWh@carbon>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YmdeCqi6wmgiSiWh@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/26/22 05:50, Roman Gushchin wrote:
> On Mon, Apr 25, 2022 at 01:56:02PM +0300, Vasily Averin wrote:
>> +
>> +static inline struct mem_cgroup *get_net_memcg(void *p)
>> +{
>> +	struct mem_cgroup *memcg;
>> +
>> +	memcg = get_mem_cgroup_from_kmem(p);
>> +
>> +	if (!memcg)
>> +		memcg = root_mem_cgroup;
>> +
>> +	return memcg;
>> +}
> 
> I'm not a fan of this helper: it has nothing to do with the networking,
> actually it's a wrapper of get_mem_cgroup_from_kmem() replacing NULL
> with root_mem_cgroup.
> 
> Overall the handling of root_mem_cgroup is very messy, I don't blame
> this patch. But I wonder if it's better to simple move this code
> to the call site without introducing a new function?

Unfortunately root_mem_cgroup is defined under CONFIG_MEMCG,
so we cannot use it outside without ifdefs.

> Alternatively, you can introduce something like:
> struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
> {
> 	return memcg ? memcg : root_mem_cgroup;
> }

Thank you for the hint, this looks much better.
	Vasily Averin
