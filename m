Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9894E417767
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346995AbhIXPW5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhIXPW5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 11:22:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AFCC061571;
        Fri, 24 Sep 2021 08:21:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 81so6632973pgb.0;
        Fri, 24 Sep 2021 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IWRHE1IksF7N6nES1jMNs1UVooFjxKrNMdCiqYqknKk=;
        b=UDZUjjkUoxBjfAQ4BcGh4zDS6QNQMedJm0c91MDS4B53lfGBP9hGwV9ieWJBUDrTmP
         qiSULABKykEaSMPub+/ykJ+xFAhIFg33dF5IfSUeIwMU+fgKn+dVt5+345rOe/v7v9vF
         yrZO+2N2Gy+eoy5nrHcyzePL3ShWtfm6R2q2LyfMwe9kW1TetvHPgCs4+gQUZZ6kIAyV
         GHHeXQlN9PrCyn5NNn2SGwoxTONbk5Pb6XSBIJ7AwMOTb5mzGqr/GDHJU+NZFZLXTW74
         QzV+R1/l01RJacrzEcTvnwVL5MAhxkawdgzfhBj5BiggvEesd1jjuKbgKKfr6PegH/9s
         qeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IWRHE1IksF7N6nES1jMNs1UVooFjxKrNMdCiqYqknKk=;
        b=z5Dy0W7lHsktvjTyV+vuO1UTTO1sHofPsKC4040sI+dGIGniApAHMN5GnBHJSKBK9Z
         Dd1l1ZKtbGNArQD54puOgX8RQbZlaQqcfYqRUVgcdmp9h/kuvQpWvkJhda7/+mzP8MAf
         +qyZ6waB//df2K3H8eD8C3dDDgofMBj50CRtCUum6ztpKj8uA/VG2KJ4nIkbMNX+psAI
         6Nj/sToKasK7nyENjC6WrIA6N4KPRlgrml2kFBYWAfWyEhJyGShDFMMlxhxQxLMcMg4/
         Y3Qqd7XaszIX/WTwDJOVf0F+vlre9ezXLtRhdoRZp2tYpyH7JFwj0dkN7lZX5dmixkAg
         zghg==
X-Gm-Message-State: AOAM531HodKi5mvkzdrjWZf8DEck4MtgXmbME9jKUS3XUsg6aUgAF8jV
        j/jBTd8ZyMkeFHniUh7j/f30fQ3JBeIUlA==
X-Google-Smtp-Source: ABdhPJztuTTCd9H3MpAGQ3cfglzf1jqB8RVKpKosmZw6gUd4JSHLxUQa0SZYZqQ/j8o9+PTszHpRQw==
X-Received: by 2002:a63:d34f:: with SMTP id u15mr4232594pgi.200.1632496883270;
        Fri, 24 Sep 2021 08:21:23 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.114])
        by smtp.gmail.com with ESMTPSA id g8sm9004444pfv.51.2021.09.24.08.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 08:21:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] mem_cgroup: optimize the atomic count of
 wb_completion
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <1632465983-30525-1-git-send-email-brookxu.cn@gmail.com>
 <YU2boTZhfbo0h/Xi@dhcp22.suse.cz>
 <03145735-7764-4cd4-e15b-60402f4b447e@gmail.com>
 <YU3aT7i2vBNxewam@dhcp22.suse.cz>
From:   "brookxu.cn" <brookxu.cn@gmail.com>
Message-ID: <df9c2c8e-bc28-d929-c2e1-18f6f91ca336@gmail.com>
Date:   Fri, 24 Sep 2021 23:21:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YU3aT7i2vBNxewam@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for your time.

On 2021/9/24 10:01 PM, Michal Hocko wrote:
> On Fri 24-09-21 21:02:52, brookxu wrote:
>> Thanks for your time.
>>
>> Michal Hocko wrote on 2021/9/24 17:34:
>>> On Fri 24-09-21 14:46:22, brookxu wrote:
>>>> From: Chunguang Xu <brookxu@tencent.com>
>>>>
>>>> In order to track inflight foreign writeback, we init
>>>> wb_completion.cnt to 1. For normal writeback, this cause
>>>> wb_wait_for_completion() to perform meaningless atomic
>>>> operations. Since foreign writebacks rarely occur in most
>>>> scenarios, we can init wb_completion.cnt to 0 and set
>>>> frn.done.cnt to 1. In this way we can avoid unnecessary
>>>> atomic operations.
>>>
>>> Does this lead to any measurable differences?
>>
>> I created multiple cgroups that performed IO on multiple disks,
>> then flushed the cache with sync command, and no measurable
>> differences have been observed so far.
> 
> OK, so why do we want to optimize this code?

Just a optimization point discovered during the diagnosis, no
behavior change.

> 
