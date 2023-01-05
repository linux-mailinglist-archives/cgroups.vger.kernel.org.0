Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1893E65E60A
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 08:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjAEH22 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 02:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjAEH20 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 02:28:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C752764
        for <cgroups@vger.kernel.org>; Wed,  4 Jan 2023 23:28:24 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v23so38991334pju.3
        for <cgroups@vger.kernel.org>; Wed, 04 Jan 2023 23:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qt1/1jt/A2jfQF0MWqTApdHyZ/eifCsttJnc6t5bAhc=;
        b=ljjg/ss9Lr0VO0mLUyc8ixTvn6Ok2pFNoVH+NGeMcx1aPc7QRcxbtAKSBTSKNkWSJL
         Nb/hAeuEZCNR9DsrceMmOedZ/y3fCBj7dVamRS83iFoMnySckQHIqS9y2lWDvFGNmUKQ
         LZQZwPi91qAHOF/LoG+aTj8j0fkARFuKmXRNt4gAia446UDCDgELl3oY78P8vDyEEn1A
         QbJNDLj/IvL8GY6MRRNWNXXGYhMsgxi2LRYKivmjdjG8Cn0zSBNmLK+lGzTdFKTDrxVM
         eu7DTiCavtT8mJeqwi0Thp1Sj87Sn9tp9v1eS6DoCk9AdWdne67kBmKDkumdQyFuaVqx
         9ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qt1/1jt/A2jfQF0MWqTApdHyZ/eifCsttJnc6t5bAhc=;
        b=L6NDg7FlJADhuU8kWCSxPIT5flC7Ltw6NcYbYJZpd60QgZbl7rOLJQ1DJJIkTyoQi+
         ddJ6+xxVJkIfpcVPJ0WXTZOxY8Ptaz6Rt0zWNqP7Q5jgcmEe7w5exSHu9GJV6dYcjRo1
         +rZ+DUILVO9+i7df2AU2RCqUvHG/Mi3eIe1Q9ZTZa1mpWRhPDUrtUESU9iDyG7P8bIXT
         HFMUPLMY0DlPGP21SppQ81Sdc82lBxGpQiqdHAhxoMa9faGt0IZSPSqh5o+DUdPM592H
         huKy1vANgtoqS23BkREmOzd7E1qnLmLayp4nl4B1rH52MhZeCktuDaOXLWNH66Gc/Scw
         HpBw==
X-Gm-Message-State: AFqh2krgbk18V/bM2J6CnJr7ftsTmay3riE3MbHcpSkbrJqAgPWrLtsm
        8Uw6MQxODuHPNcYKU6qPle/QbA==
X-Google-Smtp-Source: AMrXdXsnbMemu2nVkzxSdqMRJx7ZyMX5+UPy2NhBqROjcigZp5T+NspeFAmJU3SqyL94m5ik8saxFw==
X-Received: by 2002:a17:902:c9d2:b0:192:ee98:664c with SMTP id q18-20020a170902c9d200b00192ee98664cmr3888405pld.54.1672903703559;
        Wed, 04 Jan 2023 23:28:23 -0800 (PST)
Received: from [10.3.153.16] ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709029a4400b00189af02aba4sm25421862plv.3.2023.01.04.23.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 23:28:23 -0800 (PST)
Message-ID: <4d4f0a3f-6906-0c9b-1b56-22b9ff8795d4@bytedance.com>
Date:   Thu, 5 Jan 2023 15:28:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <Y7X5rsnYCAAYRGQd@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y7X5rsnYCAAYRGQd@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/1/5 上午6:11, Tejun Heo 写道:
> Hello,
> 
> On Mon, Dec 26, 2022 at 09:05:05PM +0800, Jinke Han wrote:
>>   static void throtl_pending_timer_fn(struct timer_list *t);
>> +static inline struct bio *throtl_qnode_bio_list_pop(struct throtl_qnode *qn);
> 
> Just define it before the first usage? Also, I think it'd be fine to let the
> compiler decide whether to inline.
> 
>> +#define BLK_THROTL_SYNC(bio) (bio->bi_opf & (REQ_SYNC | REQ_META | REQ_PRIO))
> 
> Nitpick but the above is used only in one place. Does it help to define it
> as a macro?
> 
>> +/**
>> + * throtl_qnode_bio_peek - peek a bio for a qn
>> + * @qn: the qnode to peek from
>> + *
>> + * For read qn, just peek bio from the SYNC queue and return.
>> + * For write qn, we first ask the next_to_disp for bio and will pop a bio
>> + * to fill it if it's NULL. The next_to_disp is used to pin the bio for
>> + * next to dispatch. It is necessary. In the dispatching  process, a peeked
>> + * bio may can't be dispatched due to lack of budget and has to wait, the
>> + * dispatching process may give up and the spin lock of the request queue
>> + * will be released. New bio may be queued in as the spin lock were released.
>> + * When it's time to dispatch the waiting bio, another bio may be selected to
>> + * check the limit and may be dispatched. If the dispatched bio is smaller
>> + * than the waiting bio, the bandwidth may be hard to satisfied as we may
>> + * trim the slice after each dispatch.
>> + * So pinning the next_to_disp to make sure that the waiting bio and the
>> + * dispatched one later always the same one in case that the spin lock of
>> + * queue was released and re-holded.
> 
> Can you please format it better and proof-read it. I can mostly understand
> what it's saying but it can be improved quite a bit. Can you elaborate the
> starvation scenario further? What about the [a]sync queue split makes this
> more likely?
> 
>> +/**
>> + * throtl_qnode_bio_pop: pop a bio from sync/async queue
>> + * @qn: the qnode to pop a bio from
>> + *
>> + * For write io qn, the target queue to pop was determined by the disp_sync_cnt.
>> + * Try to pop bio from target queue, fetch the bio and return it when it is not
>> + * empty. If the target queue empty, pop bio from another queue instead.
> 
> How about:
> 
>          For reads, always pop from the ASYNC queue. For writes, target SYNC
>          or ASYNC queue based on disp_sync_cnt. If empty, try the other
>          queue.
> 
>> +static inline struct bio *throtl_qnode_bio_list_pop(struct throtl_qnode *qn)
>> +{
>> +	struct bio *bio;
>> +	int from = SYNC;
>> +
>> +	if (qn->disp_sync_cnt == THROTL_SYNC_FACTOR)
>> +		from = ASYNC;
> 
> ?: often is less readable but I wonder whether it'd be more readable here:
> 
>          from = qn->disp_sync_cnt == THROTL_SYNC_FACTOR ? ASYNC : SYNC;
> 
>> +
>> +	bio = bio_list_pop(&qn->bios[from]);
>> +	if (!bio) {
>> +		from = 1 - from;
>> +		bio = bio_list_pop(&qn->bios[from]);
>> +	}
>> +
>> +	if ((qn->disp_sync_cnt < THROTL_SYNC_FACTOR) &&
>> +		(from == SYNC))
> 
> Why the line break? Also, this may be more personal preference but I'm not
> sure the parentheses are helping much here.
> 
>> +		qn->disp_sync_cnt++;
>> +	else
>> +		qn->disp_sync_cnt = 0;
>> +
>> +	return bio;
>> +}
> 
> Thanks.
> 

Thanks. Your suggestion is detailed and helpful. I will accept it and 
send the v4.

Thanks.
