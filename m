Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F356688B7
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 01:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbjAMAyL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 19:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbjAMAxu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 19:53:50 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4454D120A8;
        Thu, 12 Jan 2023 16:53:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id g68so12862262pgc.11;
        Thu, 12 Jan 2023 16:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFhlmdG7Cx41399yo/ozHBL4wwrrh2PAewE6ufP94qA=;
        b=i6ekoKSewTItPgRE2QdLfrvZixqAENBhz4Yj1/vL3BIQX1WDTpF0k3GyYEmg0KIHxA
         wj+1HMU7ALqFSNrA9RlqGF4D/uEBUivlqxRFfFOol7sG1QIJ1Sw2zxDYHbNQIys/Qsky
         0NFmblrpzx0KKcGh8kB+gjKI8HWtpVlNhmvIdyqXpDUvEnmzDJXr7Od4S3iqm/kBPJFZ
         vh4y1phX2awKQOOPubl5cOJ3nzq2TOqpX3SUlgiRM9D7awAY5ju8+KGxseEdOdDZZsoa
         fltbWpnTBk5i6j0UldFDab4ttCBFzpQSgO25zUk2bw5vHS/A6x2A/K5WVpUVGXOfc1WB
         PCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFhlmdG7Cx41399yo/ozHBL4wwrrh2PAewE6ufP94qA=;
        b=sPNER0SSxSLZ2OMAITrOsXnXdf7Amug05ta/Dn8xiiFuX9GYqK2/w+nUc69xs1Ex/+
         qR457qz4+dgGC3YS9gNq0RLBXDJiuaIGdoAuoWilhomfGBui2O1xo08yYy+zgLoGmmjO
         XRJTLLLXS0LxAkfDh6HIZMVGjBt5EqZNyDUuvfk3Hw5zJB1UnplvF+wZmlS4vrF5EvK3
         vEGbBKuahzL6B2IYSEHugQK/qHVDG4ItWZV8GKrXfJW9JlbLvQiUxYY1cORd/0GxrANS
         RKLyEG+0Olw3CvHrUTLgYqdK8Ox7HdF0Ij73YkuTZbPvj7369mhe+tMzAHm8kAmb6qFF
         qFgw==
X-Gm-Message-State: AFqh2kq7ugmShcpvZl4i+Lt4S0o4FWiJ93FqNtVsKF8oI8MQO2LHCSbU
        psXm9WcAouwFJ7qHbLXZFBY=
X-Google-Smtp-Source: AMrXdXu1X9KPr22ssxKflYXC/u/tn02ODq8xROkMYqYHhkQZxtO2R5++OCViQ3yaiUe/98rn3BkSUQ==
X-Received: by 2002:a05:6a00:993:b0:581:c2d3:dc5e with SMTP id u19-20020a056a00099300b00581c2d3dc5emr67010322pfg.11.1673571224295;
        Thu, 12 Jan 2023 16:53:44 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w9-20020a628209000000b0058a72925687sm6065388pfd.212.2023.01.12.16.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:53:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Jan 2023 14:53:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Message-ID: <Y8CrloCDGhbU42OH@slm.duckdns.org>
References: <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
 <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
 <Y7iCId3pnEnLqY8G@slm.duckdns.org>
 <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
 <Y7xbpidpq7+DqJan@slm.duckdns.org>
 <a71f997f-6cae-d57b-85dd-2fd499d238f6@huaweicloud.com>
 <Y72wF/b0/xNRmP7f@slm.duckdns.org>
 <53b30ac8-d608-ba0b-8b1b-7fe5cfed6d61@huaweicloud.com>
 <Y77s0f741mFfGlTO@slm.duckdns.org>
 <4aeef320-c6c8-d9b4-8826-d58f00ea6264@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aeef320-c6c8-d9b4-8826-d58f00ea6264@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jan 12, 2023 at 02:18:15PM +0800, Yu Kuai wrote:
> remove the blkcg_deactivate_policy() from rq_qos_exit() from deleting
> the device, and delay the policy cleanup and free to blkg_destroy_all().
> Then the policies(other than bfq) can only call pd_free_fn() from
> blkg_destroy(), and it's easy to guarantee the order. For bfq, it can
> stay the same since bfq has refcounting itself.
> 
> Then for the problem that ioc can be freed in pd_free_fn(), we can fix
> it by freeing ioc in ioc_pd_free() for root blkg instead of
> rq_qos_exit().
> 
> What do you think?

That would remove the ability to dynamically remove an rq_qos policy, right?
We don't currently do it but given that having an rq_qos registered comes
with perf overhead, it's something we might want to do in the future - e.g.
only activate the policy when the controller is actually enabled. So, idk.
What's wrong with synchronizing the two removal paths? blkcg policies are
combinations of cgroups and block device configurations, so having exit
paths from both sides is kinda natural.

Thanks.

-- 
tejun
