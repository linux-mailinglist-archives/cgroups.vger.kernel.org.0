Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7C673FA9
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 18:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjASRNz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 12:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASRNy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 12:13:54 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1ED4DCE4;
        Thu, 19 Jan 2023 09:13:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 12so149685plo.3;
        Thu, 19 Jan 2023 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFfg4vjHMlgAnxwHU0IZDYXZDE9o/oiWwSlrAYq3R5g=;
        b=X+pv9m4dyfqTTh7NZfU1L4amF07biWIPm63cC9fNYYpkbNI0qpBHzcRDEv4T/Ejr6i
         A8E2+JfZ8da4ELFsiatHjimOU/8/kDX4+Q2aI4BH5PlPLP/vNFa9ivtY4/SeqnH4eQt7
         3e5QyZ3SiaUZmmuYD2krSfow7EB8PfehPb2FJ6/jkd4AvvjmG/wMjAWv6r4mxsNPgLQ+
         YEk2ItBSLWk4QGxz9SHfCz73gwCT0SaDHLePGGsb//2+m8NuJX4oBZtDS2poXWWNLHfE
         CesCZu9SCOOJuAaxeea6v6eSExq26OGrje6hH+Q7kSvUlpXYKXyfvWO0f+X1BxpOsUGR
         IX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFfg4vjHMlgAnxwHU0IZDYXZDE9o/oiWwSlrAYq3R5g=;
        b=IFSJmy5NYqZlQ0iTRl+4J8aiM5LKjBkSdiCwB9xbdC2NvQLn+Ij0snXtESIu8DgTRy
         phua9lKFIe/rrrwT5T9xDZjl9Y6yP+eFUF4HRMRxJvSTvChNV2grnitDamSyvIQyKZfi
         U26S7rs+CNScvx9sDffMml4ZTeYuvKbogK0uekjxOb1X5JKQaG8eBBJ8hKdgoPqQ+486
         r0Ltnon3O38JmxIHdOzQEMc12Bg50s4RfSjK8ygExPXNK3DAxfblKI8RyAS1HjdPri4x
         HH+ttPQ5LRcv2CfI5H/8Lxx6vbhj3iexOBBxj09dBD+VtB+5BOPYJ0Pv6osmd3Y+Dbfq
         37AQ==
X-Gm-Message-State: AFqh2kpEzCq0h9rfGyyw2k0aAVwckG1nNICWZtF48RoC7Gwptqnj6Ks2
        U+i76S1uSAHu6bY1PP5LDko=
X-Google-Smtp-Source: AMrXdXs2mFA/OwbxBCuHRWmgmsuQjXGvbvfgePhmcD+Y2Nd7vLoGSKS6AH9stxCTjLb8hktGmkko3g==
X-Received: by 2002:a17:902:e84b:b0:194:ddc2:60e8 with SMTP id t11-20020a170902e84b00b00194ddc260e8mr428202plg.48.1674148432849;
        Thu, 19 Jan 2023 09:13:52 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b00177f25f8ab3sm25431298plh.89.2023.01.19.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:13:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 Jan 2023 07:13:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: switch blk-cgroup to work on gendisk
Message-ID: <Y8l6TySjEuGT9Q+5@slm.duckdns.org>
References: <20230117081257.3089859-1-hch@lst.de>
 <Y8l34/qeHPLV4rKJ@slm.duckdns.org>
 <20230119170526.GA5050@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119170526.GA5050@lst.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 19, 2023 at 06:05:26PM +0100, Christoph Hellwig wrote:
> Yes, it can.  Not sure if my sentence was unclear, but:
> 
>  - everything doing non-passthrough I/O only should be in the gendisk
>  - everything related to blk-mq, including infrastruture for passthrough
>    should remain in the request_queue
> 
> The idea that the request_queue will eventually become a blk-mq only
> data structure and not exist (or just have a very leight weight stub)
> for bio based drivers.

That makes sense. I was thinking about it the other way around. Yeah, genhd
would exist for everybody. request_queue only for the ones which are
actually handling rq's.

Thanks.

-- 
tejun
