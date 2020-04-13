Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131561A6C36
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 20:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbgDMSuS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728106AbgDMSuQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 14:50:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF046C0A3BDC;
        Mon, 13 Apr 2020 11:50:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h9so11242995wrc.8;
        Mon, 13 Apr 2020 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ypxii2YE5TJTFobtoZ3bxlwCYM5c9IgWRJHcbubUIFk=;
        b=stGWxXpq1iqGKETDz+BqkKspCAA8HAaoSsEoFBqNgOSwYmGZYnCOQ48O/wxD8RI/eG
         L/lwKPwRpo6mgoDpzKKR7nqgyt3Jzh+NNTW6mBGX0QjsDmNzBqhGKu5JADbHNVEbr85e
         wR6/09CEZpUKuNeMqwClEXulk5fCbTmNPT2fCxZ5oWOJENPwZNn22/TD/pjtwolQ0IZV
         JEkVQYSu5uifIrCsBUL89UU+qeBwSXTNEeDNIp64SaIJhi+OwEsJjiBgagZwla1Sfu9j
         B6GkxpaiS9dtPWgr8rmSOT1t7HIKq1cV5539hC491XOJGGlHTi+YIY4LLJ+nioXfvGQP
         iw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ypxii2YE5TJTFobtoZ3bxlwCYM5c9IgWRJHcbubUIFk=;
        b=fVdXtYuFSe0luVJelZrjHjUCS7E9d7Nu0aPz2U1tUz3i1NcIXQWqQSQH58pNN7Kjas
         iggaD09PaE6nYyv1aTGlQOGtkM9bE8IZS6VDhNZuBkode0iOIMk0idEiBUDxtRnd/J15
         ifvSaOZzE9VKqj0OEGRWpcOLQL+6vF0moKaa8TKBMRxyGLJQx1Pto9VC02yo4VxZexJX
         Y6q0kWKOPYAQkRTYrOGjq1ZfxQJvkdjci1HqOikBy0QcsVLuPw9jsDyvk/QdHdh2Z1sQ
         Y1cwDxL55TSSclv9pQI7mrmc6zU9MGdRXyG6QudLoghS1wm7xP5js6YjMPywrXNumLgg
         Y9Sw==
X-Gm-Message-State: AGi0PuZxaO9/MH70m4/idgSjQ0BcDs49GeJQetJVMs88RGB26RdT+RyG
        XjCTNPNkWzbDkvsLFzM1t1Y=
X-Google-Smtp-Source: APiQypJkXvKXCTDzsz294XYjN0s2ZCmu2STZJUCXRZi2oslRuzp+B1IAgPpN7X7B42f3xovLHkTxMg==
X-Received: by 2002:adf:97d9:: with SMTP id t25mr9627400wrb.157.1586803814340;
        Mon, 13 Apr 2020 11:50:14 -0700 (PDT)
Received: from [192.168.43.75] ([109.126.129.227])
        by smtp.gmail.com with ESMTPSA id y18sm16650962wmc.45.2020.04.13.11.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 11:50:13 -0700 (PDT)
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        cgroups@vger.kernel.org, newella@fb.com, josef@toxicpanda.com,
        ming.lei@redhat.com, bvanassche@acm.org
References: <20200413162758.97252-1-tj@kernel.org>
 <dd55f890-740c-16b5-77bd-4c6fdb710b3d@gmail.com>
 <6f69d35c-c593-f140-c351-c7fd2c13069e@gmail.com>
 <20200413170833.GD60335@mtj.duckdns.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCHSET v2 block/for-5.8] iocost: improve use_delay and latency
 target handling
Message-ID: <5d2e4017-563b-4a2e-58d7-7af6e3183569@gmail.com>
Date:   Mon, 13 Apr 2020 21:49:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200413170833.GD60335@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 13/04/2020 20:08, Tejun Heo wrote:
> On Mon, Apr 13, 2020 at 08:00:29PM +0300, Pavel Begunkov wrote:
>> On 13/04/2020 19:56, Pavel Begunkov wrote:
>>> On 13/04/2020 19:27, Tejun Heo wrote:
>>>> Changes from v1[1]
>>>>
>>>> * Dropped 0002-block-add-request-io_data_len.patch and updated to use
>>>>   rq->stats_sectors instead as suggested by Pavel Begunkov.
>>>
>>> rq->stats_sectors is set only when there is QUEUE_FLAG_STATS, see
>>> blk_mq_start_request(). I don't see blk-iocost requiring it. Did I miss something?
>>
>> And there is no reason to not initialise it unconditionally.
> 
> The updated patch turns on accounting when iocost is enabled on a queue.

Great. FWIW, if you don't really need accounting, it'd be IMHO more robust and
with less overhead just to do this ->stats_sectors assignment unconditionally.

> 
>   @@ -2267,6 +2295,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>    	spin_lock_irq(&ioc->lock);
>  
>    	if (enable) {
>   +		blk_stat_enable_accounting(ioc->rqos.q);
>    		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
>    		ioc->enabled = true;
>    	} else {
> 
> Thanks.
> 

-- 
Pavel Begunkov
