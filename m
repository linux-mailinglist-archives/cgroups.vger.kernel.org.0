Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0390A51005D
	for <lists+cgroups@lfdr.de>; Tue, 26 Apr 2022 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351588AbiDZO2G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Apr 2022 10:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351025AbiDZO2F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Apr 2022 10:28:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B425A083
        for <cgroups@vger.kernel.org>; Tue, 26 Apr 2022 07:24:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so36435262ejb.6
        for <cgroups@vger.kernel.org>; Tue, 26 Apr 2022 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGi2xWo0glztPoHlb3pGflxD9oTprLjQ3hPK/vMNf9g=;
        b=hQ7W0BWcpUkQc/T8HXofDKebFeuGCBNPA5SZVDUfqR/Wgw7Qois8SYRnyk9WOoAHeu
         F/9jI9kUIifVKMlpQKopUdI/JZsUhYq/vQcqeQK4/nxr9MspWekGKFdgaWjZZsQVqxhu
         tmS+2B+y3iD7cVRg0aBWsQnviwtyJcRl60tsNuO09pmmr2LGiuSl+b9edYTc8nrargte
         ufPok664AcZ7cV+an88gvuWIEVSJMo3IR31ozD8FfRbz1dZEA5V21oxe1GZ9V7jSg/cU
         hgKUeLqYaG8JBRTtZFaqg06j5HFctbBkAB4mjjXcEmG4ci7ClXQz0YfqeQxhVk0uUDy0
         5fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGi2xWo0glztPoHlb3pGflxD9oTprLjQ3hPK/vMNf9g=;
        b=q863BzKOA0lB7P6sHvp08Nyf1rOOrlMZyDa8S2WZ4JQP0iUlaTa/zSxceT/5y7QRYv
         sB8tzexTeKO9Spqa25Cb1y7YxKg7FExnj8qmyvme/mwMt5dNulzLvbEmKfcGGox67tja
         bIHPrQlOYR7+A4kuYZpI5hfufFHJn+RluJTHKyzBFn6MQrKLqzk1pEkOZmwJQTo9nK5J
         NAL9kF2bBbniEGOqH8J1xlc9c5nlR54F98yHbyC1oGmKK6T0yr4llCmLkH8ln1AxldZ/
         SogeqH1guYN4YeB2WJSPm2ir2rCykLyW88Y2YQQr7WwJTUIEh2AimwYif8nGcQPcPvho
         9bAw==
X-Gm-Message-State: AOAM532spgGaFJhUdmvCk4W0076DRhtY2pUIvoza4b/AkDwuwrTLimGm
        PsM6YdDjXnKNpP23TvutUQT1uQ==
X-Google-Smtp-Source: ABdhPJwqgfbj1kmKNaRApziMfN3y1y0mgZBxvHxiI0QR5TzVpevciWSnaiC3oLvOhLwmBH4Io+45bQ==
X-Received: by 2002:a17:907:86ab:b0:6e8:d60e:d6c3 with SMTP id qa43-20020a17090786ab00b006e8d60ed6c3mr21366841ejc.346.1650983095263;
        Tue, 26 Apr 2022 07:24:55 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm4976128eje.183.2022.04.26.07.24.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2022 07:24:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next 00/11] support concurrent sync io for bfq on a
 specail occasion
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220413111216.npgrdzaubsvjsmy3@quack3.lan>
Date:   Tue, 26 Apr 2022 16:24:51 +0200
Cc:     Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: 7bit
Message-Id: <7C91FB1F-0690-4D1C-A631-98236F6DC55F@linaro.org>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220413111216.npgrdzaubsvjsmy3@quack3.lan>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 13 apr 2022, alle ore 13:12, Jan Kara <jack@suse.cz> ha scritto:
> 
> On Sat 05-03-22 17:11:54, Yu Kuai wrote:
>> Currently, bfq can't handle sync io concurrently as long as they
>> are not issued from root group. This is because
>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>> bfq_asymmetric_scenario().
>> 
>> This patchset tries to support concurrent sync io if all the sync ios
>> are issued from the same cgroup:
>> 
>> 1) Count root_group into 'num_groups_with_pending_reqs', patch 1-5;
> 
> Seeing the complications and special casing for root_group I wonder: Won't
> we be better off to create fake bfq_sched_data in bfq_data and point
> root_group->sched_data there? AFAICS it would simplify the code
> considerably as root_group would be just another bfq_group, no need to
> special case it in various places, no games with bfqg->my_entity, etc.
> Paolo, do you see any problem with that?
> 

I do see the benefits.  My only concern is that then we also need to
check/change the places that rely on the assumption that we would
change.

Thanks,
Paolo

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

