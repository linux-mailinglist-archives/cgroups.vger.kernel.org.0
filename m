Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A557595DE7
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiHPOBp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 10:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiHPOBn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 10:01:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDAE6D9E5
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 07:01:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jm11so7069904plb.13
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=erk4QjfKLI1wqXEF6e5iSvx1UiCDlKAdjqB4/lN4Erk=;
        b=Y0g/2vtkm1HDsEQno8ZsLNKBwZANZXHmx08W3wcN28MC03rqN8MuI64iRs+rHEj/xM
         Mhgh3CWWqwIHvp1zbpwHD9c7qXg8eE0IRMI8lE/Bs7Oc8V/33m9VXiuhskmTBfgxD9NZ
         Mq62JekBPMAcUxs3Ilcqg2rqG1qAlFVad2zD270PHvYGPCENWlJsVUgAAgaml9ycj8+R
         a3jNEi3vDV1kpIpykK09HTqW8zI8WIjy7FGbgBfUo8YJAns9J0U7Fg6u4PI2mpVSLveW
         3onWPrEs8plVxEpuEm8C8LSAqbQuxfh0aI9mUsW5fx9yeIMqQ/EHbVhAWxDUX3eJSAq/
         eMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=erk4QjfKLI1wqXEF6e5iSvx1UiCDlKAdjqB4/lN4Erk=;
        b=OtGnRx9vsOhiXbR9HiFKTxAe7aeSQuy3cbHJWOw41TL2Rhn7OHka0q8Y7DfupWSIwL
         d1S3WtgVE8n8WdI9E+X+4NU1uRHkuntuRhxQmqAx0/DDyKMFl/1hI08cNP1BTVbN4JF+
         z9W+y8QOXqBnoJHXBQY/nyTRYYqn7DJAKpa7sadsKoIxv6Qre3C3fAog48vVlRfaf+GL
         qW8QMfcxo+8Y4pwFYj4a2bm0+pg0usoqmdRBBIUe2P3CBBU+JE/eqHQh9ntdUs655e8Z
         cVT1zAimBZjAH7IgkAXOPVCWx7ck+mocREFLXUoYsCZuPg3b0aqECOl3HShNqdzX5B9c
         hrXw==
X-Gm-Message-State: ACgBeo3TYXiSIg7p8atNAL06zqGzp5tds/9ToF/ptPvyJYJQr6rWe+S2
        qzI/yMvKq+60WWNd/r/cNVG+yA==
X-Google-Smtp-Source: AA6agR5Vh5FoZEV/vDsCM3Tgms3lMElLgMMSYRP2EDYbKRNWdE3cxEILRzOEG90g4VS6xpelMOT0Tw==
X-Received: by 2002:a17:903:2291:b0:16e:cf55:5c72 with SMTP id b17-20020a170903229100b0016ecf555c72mr22182498plh.121.1660658501401;
        Tue, 16 Aug 2022 07:01:41 -0700 (PDT)
Received: from [10.4.196.37] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id r35-20020a17090a43a600b001f522180d46sm6396363pjg.8.2022.08.16.07.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 07:01:41 -0700 (PDT)
Message-ID: <08ec9c4f-80b2-f731-aa8b-fb4e852ece25@bytedance.com>
Date:   Tue, 16 Aug 2022 22:01:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v2 00/10] sched/psi: some optimization and extension
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220815132514.GB22640@blackbody.suse.cz>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220815132514.GB22640@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/15 21:25, Michal Koutný wrote:
> On Mon, Aug 08, 2022 at 07:03:31PM +0800, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>> This patch series are some optimization and extension for PSI,
> 
> BTW do you have some numbers/example how much these modifications save
> when aggregated together?
> 

I lost my test data last time, I will use mmtests/config-scheduler-perfpipe
to get some performance numbers right now.

Thanks.
