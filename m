Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC005F33F5
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 18:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiJCQ5l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 12:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJCQ5k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 12:57:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17726473;
        Mon,  3 Oct 2022 09:57:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso4192834pjf.2;
        Mon, 03 Oct 2022 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=4YG/tGIVB3HXKHAYKxLgnveb2mUS1J/Za8cyWbqcRbY=;
        b=FkJ7Es97xxSs2YAwhLK8TWOlLFBmMY1bjwqO34bON1COwPd5PRuVMtod/7QuUDDP75
         lyGv2r8xUrcSL4SC/ho84tRSmnMjc1A7v2eVQwSZC+9jPIAw3FZKbwcSSSa0JAHVerlL
         tUId1KvIk/wz8cuyRjMqeDZussaQl9dkC3WBNQ2zyfmtNxCcJwbA6Y2coMWu8HWXwYq4
         d3kXjSueMVuQ6Ch9ie42kTHwezmnqf4HtTdMdRiVpVuXuiKUrvczQOARSIk35gTzeNKq
         ZVQGMh9ULifYhtp9fmbXQ5lGEGp0bPhcEicdp3OsGvll+22pQF04LA8aVfwpchQItbz0
         ZNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4YG/tGIVB3HXKHAYKxLgnveb2mUS1J/Za8cyWbqcRbY=;
        b=GBPEbPa5dGyMO4vnnBdJyquaE1D7MoFmpMqkM8XfUc72+Sf4suMtZMTkyrU3Ol1IkG
         YsFxx+jpQrQ7838TiL3xaUKwal6OIIbOo/VS7Lzo3kPISO3L5v27T/6t9wINtOTY/dCL
         r4qcGDSGrUsNtfcg06lR/zEmoy9XpB4oaU8VZk8m4oFBCimyVOsiqNmOgatSNyvy3v1m
         8exaKj2p4OigHDQ3rNx4Qd3EY/6hTyPde5ktRx7q+wYr8yVArLL43QyCo8/kfcMeGeUp
         2PfaYVl8iDJW9FQ/8O/MqkDLO+ll8kAa6rsjxDF3LYETrj1HQJ1gdHJEoYXmKzT5HRtm
         N2YQ==
X-Gm-Message-State: ACrzQf19C+gQ8jAsfCbPWWqZUA8RdgGr3yBAq/ZKwdwSJ7NWKjBMcg8C
        p4TJ+e4UAt02FAxU1qFrHsg=
X-Google-Smtp-Source: AMsMyM52yEjEogu5ov5b/m0kWUDXWzTFGlqrb9LbWrTDu+Degn+hKD3tzHqLc4ctyJhx6lfybnjhaw==
X-Received: by 2002:a17:90b:4b82:b0:20a:cb3f:fae5 with SMTP id lr2-20020a17090b4b8200b0020acb3ffae5mr1012273pjb.153.1664816258943;
        Mon, 03 Oct 2022 09:57:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b001728d7c831asm7450432plh.142.2022.10.03.09.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:57:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 3 Oct 2022 06:57:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v7 1/3] llist: Add a lock-less list variant terminated by
 a sentinel node
Message-ID: <YzsUgY4CC0SH8Sl2@slm.duckdns.org>
References: <20221003154459.207538-1-longman@redhat.com>
 <20221003154459.207538-2-longman@redhat.com>
 <YzsQZPONIJRgtf3o@slm.duckdns.org>
 <006ebc52-ab37-442a-9ba3-e7b8dff53fab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006ebc52-ab37-442a-9ba3-e7b8dff53fab@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 03, 2022 at 12:55:24PM -0400, Waiman Long wrote:
> That was my original plan. However, after looking at some existing users of
> lockless list, they have coded in the dependency on the fact that a lockless
> list is empty if it is NULL. I guess I can make this true also for the new
> lockless list with sentinel at the expense of a bit more overhead in the
> entry insertion path and deletion path. I will take a further look at that.

There aren't that many users of llist. Maybe it'd be easier / cleaner to
introduce a macro to test whether a llist is empty and replace the NULL
tests?

Thanks.

-- 
tejun
