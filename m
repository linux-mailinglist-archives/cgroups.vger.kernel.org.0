Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99D5A1F61
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 05:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiHZDRO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 23:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiHZDRN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 23:17:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC3CACA0;
        Thu, 25 Aug 2022 20:17:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g189so296611pgc.0;
        Thu, 25 Aug 2022 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=MB6QLwte6A+FfeHZ7hhIAgqBcop3yV3R8qqmPiooMZw=;
        b=kN4iQW7K22uT8HSAzCzZpNIGqTuTTg1AfRP4nSREd9XS7uXUVq/dVbFd/MvU4f+a3i
         iSOIKmwEkNINjdmevNcLolUMggi9tuS6AbI9CAskuTUfzapjO9tZdbbMWFeyRBU9Ftyr
         73akbvzVVGO1ZzhAtmDlv4RGK4oorSM97X+xKGrO2NPWU40UDk7ipTP005DdalS7QQ9Q
         Shw90PYt66tMBnLYnjnRHI2xIqGaTVkMzlM5vN9fL+6RF8JY1lSS87GNd9SuplsLecUH
         H1QSaIX7JbxLwxYtIEeeT8pNUEQmvpFT3jEQPUZmrngZePX2OC16YZSviQMBahljZcRR
         9BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=MB6QLwte6A+FfeHZ7hhIAgqBcop3yV3R8qqmPiooMZw=;
        b=yw8Inn7MKjYr+mm3ReYM86423sphnfUol8lXViOYKskIqzaWnOzRDoKMQh29GwcZqQ
         l9SErfd39yV+jOvSuGiKDtDynq+g3hSYCz2MpnNUd86QFv39RY4BLLsVqq6MeM3W8Kts
         WZVwKYnhZuiXePV1RQritsI85DLg0TSfeIsIpucvglZoORm2Te4N6j/F1Tb7ngvTXAoY
         z+58fVusPx3E2VIcVb9v5dNueB6YhlBIeS91LWvSJKAawny1BUcaaGbiBtWOBLz6s6Vb
         RrKESv7+RTwHvuywyfvlSTMs1dpCywYdo5o7YG8pEv/tRmdrOwogq3gxOp1vc5viUUQb
         i8Mw==
X-Gm-Message-State: ACgBeo2WvqTcqD0zETi7flcYEzkDI1dSflib7CvBwSgyBIDtbS9Ujlr3
        /lGY69oEEPLfERFOEgjvYOk=
X-Google-Smtp-Source: AA6agR6smD2vHcE27Mia/GRY6ZNxBCiJ0gJvVyPZ10/qYTnr16EBtKTMJwW7445/0IulVP9EKlAkiQ==
X-Received: by 2002:aa7:9486:0:b0:536:b212:172f with SMTP id z6-20020aa79486000000b00536b212172fmr1928223pfk.70.1661483831887;
        Thu, 25 Aug 2022 20:17:11 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b0015e8d4eb219sm316845pla.99.2022.08.25.20.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 20:17:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 25 Aug 2022 17:17:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 0/2] Introduce cgroup.top interface
Message-ID: <Ywg7NcHtfjDKjwXR@slm.duckdns.org>
References: <20220826011503.103894-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826011503.103894-1-lujialin4@huawei.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Aug 26, 2022 at 09:15:01AM +0800, Lu Jialin wrote:
> Cgroup is used to organize and manage resource available processes.
> Currently there are no handy tool for gathering reousrce usage
> information for each and every child cgroups, makes it hard to detect
> resource outage and debug resource issues.
> 
> To overcome this, we present the cgroup.top interface. Just like the
> top command, user is able to easily gather resource usage information
> , allowing user to detect and respond to resource outage in child
> cgroups

I don't think this is something we want build into the kernel. Maybe what
you want is something similar to below?

  https://github.com/facebookincubator/below

Thanks.

-- 
tejun
