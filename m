Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6617A5430
	for <lists+cgroups@lfdr.de>; Mon, 18 Sep 2023 22:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjIRUdO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Sep 2023 16:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIRUdO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Sep 2023 16:33:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF0A10A;
        Mon, 18 Sep 2023 13:33:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fc9a4ebe9so4499281b3a.2;
        Mon, 18 Sep 2023 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695069188; x=1695673988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEnHEVF0sQxeNUYZ0vdBfHCJqqJDyzd1BEi34ZYEm3U=;
        b=hMuQzLRkcNz/aszxtvzUu66z+V/pkZbL59f9lf8wALxgkUl+0BNRXJ4MTDxQQONGOy
         q479/s4OzLr6KbPsjTUB0+8uajOCR/5+Vgs1hyExvrfRlAgkPX9OX43IlZM25oA6mdjL
         FBHruqXSBxK91sPRIaKew6BuT4tjaKMjszy5YgvZhPWAyZEm8JUcm9ShpMAOvGoUZdo3
         yB9kpiLrSV8M6UszoaZmETWOHtCRh4Sqyyw+BlhYSk6fx5iJimJNFbuBlIfeU6wZ7gJt
         OyBpIuBnmK3Jj+cSQCTna5MHPEMl8HisVlAvXw0SsLthCm8vHC1XoL9G0az6J/mvZuCS
         mnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695069188; x=1695673988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEnHEVF0sQxeNUYZ0vdBfHCJqqJDyzd1BEi34ZYEm3U=;
        b=Op5XNvgAbmbHV0MSrWnHcJNX3rvFFJSXIqfy6spkD2Tu6dLzv1zZ56Azt8HMLBSvyo
         DyohIOupR69r/1CG4ZRPNH46+5nwYk1mI0XX8hmo7VO4wAxyDJM9hsz2+c0jK1T85mDv
         BvJYqPIFAuYR1HYZnV3Naamr2FRXBY84ESCcm59WutFvcaMGOvL9PKVaoWoxq7NarEzz
         eeVDF+mrG97Hd56il0GzeYs8RUNNT32uoBoEqki5fyNGD3f41SzKvTKvA2jYFI8f9Az8
         z1LVN7Q2M9/rW+EFHwH0UQmFFbSyJQGcML1wxgmrE+cGiOfpda9ppDtodIIaPWFP4PkI
         gBKQ==
X-Gm-Message-State: AOJu0YzbHbuyqMcvPwi9J/Sgobr1kfTufaN7NEc+/Z2ZW7IXheV5L1Yc
        SZ/KrCe6VMFTXeBahjlEXSA0n4Ef0hljNw==
X-Google-Smtp-Source: AGHT+IERed95QSiCHzx43lZz/euKSpl7uXrl5kMEO6Z5GV5+1eW1WB8QYKHtT5uYGs8Na3+0QMlo2Q==
X-Received: by 2002:a05:6a21:47cb:b0:153:a160:89dc with SMTP id as11-20020a056a2147cb00b00153a16089dcmr9076643pzc.58.1695069188157;
        Mon, 18 Sep 2023 13:33:08 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id c21-20020aa781d5000000b0068fe68de4e1sm7676539pfn.145.2023.09.18.13.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:33:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 10:33:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v8 0/7] cgroup/cpuset: Support remote partitions
Message-ID: <ZQi0AvvYJqaKkKG9@slm.duckdns.org>
References: <20230905133243.91107-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905133243.91107-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Applied the series to cgroup/for-6.7.

Thanks.

-- 
tejun
