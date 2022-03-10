Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615744D3E97
	for <lists+cgroups@lfdr.de>; Thu, 10 Mar 2022 02:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiCJBOw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Mar 2022 20:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiCJBOw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Mar 2022 20:14:52 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E239CA88BB
        for <cgroups@vger.kernel.org>; Wed,  9 Mar 2022 17:13:52 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d10so8761940eje.10
        for <cgroups@vger.kernel.org>; Wed, 09 Mar 2022 17:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/HElp+aQtnErb8eqKq5xR1nF/Sumgv37cBYNTIU6bAQ=;
        b=jv/5PHwiHW0AZAumnhPrVNtgtPuklBFkA1hczMZa7ImunP5cCkSlc0r1Ui5FxO3Zv7
         scs8NdWiYT1GF89qUej5glSFMcOpe5h3uI5+VpIiymJQ5lwIPDG6n23XuX2qHfw6pv9G
         D+zvAhStTgmlJbw/wYGRM4SshhrYtc2YEiENKzOT+TkTfWKRne3cSA/XO0cDsF30N2Kg
         B+vU6ydsPyKAdeswzLhPBYb3p8wIkTVbYQbLONhkUE74rRgm8vNngECUOOe6t9INblMo
         wQInb1uDdtGbUCjitYkQ94Q3BqM4vKObcHqwLuZXiVaHW87SAKJ6vjNkCbMBTQrQmLqy
         r7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/HElp+aQtnErb8eqKq5xR1nF/Sumgv37cBYNTIU6bAQ=;
        b=sFyu+ROMgkbSiDJKhkSDHO4pyBNOxML/djgs8vP292Pt7sG0B8eRsH9EfMccdeg1QY
         AbnIG5IGGEF09qX6C89AHZosTyCDv6q3mJVInTCEmmxsUsZC1IPVolDwH3Xddkq4kkRc
         H4e51Xe/EzXzY9T6t2xSgAUDVxIR3MQ1L6YqJDwL2z1foG7Nm43YLisWF4xwH2ZWMQBg
         c3zYgyK0SCvQGyJEj1V8cu/E7N59R9qvjp2Ipne4p669tV4jxS1/9XheOjm2OEp1rXAx
         1RyDVuuTH5LGykFb6X6SkHtWSZYmhndpKgCW5i6b36AEGEevhDqRg5iSSYK+T5EUkH/u
         Q+RQ==
X-Gm-Message-State: AOAM531PQW+qDxVyJT4YmpC+mTqKNQ0lqTjrFW/XADNo8zG4/CVG+EaP
        6Le6UkJSsVCK3BLHlroBlhw=
X-Google-Smtp-Source: ABdhPJzvl/4eKnTouNNwFSWpvkmI6uOs+6dIlYUZWk20s54R0a5B4+YvHt2pkvBf4PMw7rjdfZD41Q==
X-Received: by 2002:a17:907:eab:b0:6da:8ec5:d386 with SMTP id ho43-20020a1709070eab00b006da8ec5d386mr2179855ejc.668.1646874831369;
        Wed, 09 Mar 2022 17:13:51 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y18-20020aa7ca12000000b0041677910461sm1422635eds.53.2022.03.09.17.13.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Mar 2022 17:13:50 -0800 (PST)
Date:   Thu, 10 Mar 2022 01:13:50 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 3/3] mm/memcg: add next_mz back if not reclaimed yet
Message-ID: <20220310011350.2b6fxa66it5nugcy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220308012047.26638-1-richard.weiyang@gmail.com>
 <20220308012047.26638-3-richard.weiyang@gmail.com>
 <YicRNofU+L1cKIQp@dhcp22.suse.cz>
 <20220309004620.fgotfh4wsquscbfn@master>
 <YiiwPaCESiTuH22a@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiiwPaCESiTuH22a@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 09, 2022 at 02:48:45PM +0100, Michal Hocko wrote:
>[Cc Tim - the patch is http://lkml.kernel.org/r/20220308012047.26638-3-richard.weiyang@gmail.com]
>
>On Wed 09-03-22 00:46:20, Wei Yang wrote:
>> On Tue, Mar 08, 2022 at 09:17:58AM +0100, Michal Hocko wrote:
>> >On Tue 08-03-22 01:20:47, Wei Yang wrote:
>> >> next_mz is removed from rb_tree, let's add it back if no reclaim has
>> >> been tried.
>> >
>> >Could you elaborate more why we need/want this?
>> >
>> 
>> Per my understanding, we add back the right most node even reclaim makes no
>> progress, so it is reasonable to add back a node if we didn't get a chance to
>> do reclaim on it.
>
>Your patch sounded familiar and I can remember now. The same fix has
>been posted by Tim last year
>https://lore.kernel.org/linux-mm/8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com/
>It was posted with other changes to the soft limit code which I didn't
>like but I have acked this particular one. Not sure what has happened
>with it afterwards.

Because of this ?
4f09feb8bf:  vm-scalability.throughput -4.3% regression
https://lore.kernel.org/linux-mm/20210302062521.GB23892@xsang-OptiPlex-9020/

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
