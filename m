Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5697D630790
	for <lists+cgroups@lfdr.de>; Sat, 19 Nov 2022 01:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiKSAhP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Nov 2022 19:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbiKSAgX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Nov 2022 19:36:23 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A172AE32
        for <cgroups@vger.kernel.org>; Fri, 18 Nov 2022 15:43:25 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id u7so4372198qvn.13
        for <cgroups@vger.kernel.org>; Fri, 18 Nov 2022 15:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/iTpmR4sRdLv0Rk3A8XEP/l6NiYPL92CF45ZyTgAiU=;
        b=gsWF7RmdFZNApUCqHEyf0BafcUrFVHnUgIS7HhgpUNR5xF9VvlzTIR5biXLQLJAtux
         ef1rp8dfIEcWWTpYDLJSxGwb35YMj4OcmP+tdOx2Fr4vTWGgN2XS2NtPbcroIz8XKl4v
         FNhXlg07RHUWM4bfGIaZ7i6wMsSfF+pCELt+P+9QZRmTkbnrqcjpAFUZjLFsEapoxUsy
         OMy1jNRSZJsxU+SqK2GdMJbnM8ptspzNHM41EB5x1wPnpWgIDPBEHkEOa4qM4JIIXMO7
         15q1sHnkCMenDiRbzLQIew81n2tPXEb926GxiXB24xnKLs9+3HFdVuWpl6r8Oc7mlhkt
         bGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/iTpmR4sRdLv0Rk3A8XEP/l6NiYPL92CF45ZyTgAiU=;
        b=XIF5w30JoqZO9a5aptfLdK1HrSG23hcOuJQWma0BD8fn+4KSXIcgrAae+k8TNiAiny
         E3V9b2k4+zJ5/xEWkYZXO4k7dqqtKBJjFABO8Xe/q00wmcqP/7RxO/UtO0Dfn+YsDGCW
         xLBRKBu8Mv7EKjpgsZW93Yca/OfJ/n6ZdBYYfx5UGIHhZP/wr0BZ6hXId1dZnF7un8dY
         /Yjoo3OtbN2+5p/oJ3bKaGAo5ehJXTWS/qt4KYSmoPkvYjecqydf5uGTxGfwYKMx1/5T
         GWneulnpQzHm2vB49e6Z1eqKRgYhRzwaMGXapjS0Kqy8wUEyGQStA+sWbPS/abrDWHdG
         ifYg==
X-Gm-Message-State: ANoB5plsrJD4jlPxyKGJu5EO2TCr0ei1KxJbfJn0sLL6sINAWoxky8uj
        XXaCqVyXkAF+d9I0e8srsawT1g==
X-Google-Smtp-Source: AA0mqf5G/gaac1k+oIvscpizv4XMzhcrStHSf0J/I1Czc9JO0bpVKFs2vCc7zi+UWJRorpllDXYDFw==
X-Received: by 2002:a0c:8091:0:b0:4bb:b8ec:2bc7 with SMTP id 17-20020a0c8091000000b004bbb8ec2bc7mr8811778qvb.20.1668815004777;
        Fri, 18 Nov 2022 15:43:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006bb8b5b79efsm3504337qko.129.2022.11.18.15.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:43:23 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:43:46 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] mm/cgroup/reclaim: Fix dirty pages throttling on cgroup
 v1
Message-ID: <Y3gYsv6oAcJ2u0Py@cmpxchg.org>
References: <20221118070603.84081-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118070603.84081-1-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 18, 2022 at 12:36:03PM +0530, Aneesh Kumar K.V wrote:
> balance_dirty_pages doesn't do the required dirty throttling on cgroupv1. See
> commit 9badce000e2c ("cgroup, writeback: don't enable cgroup writeback on
> traditional hierarchies"). Instead, the kernel depends on writeback throttling
> in shrink_folio_list to achieve the same goal. With large memory systems, the
> flusher may not be able to writeback quickly enough such that we will start
> finding pages in the shrink_folio_list already in writeback. Hence for cgroupv1
> let's do a reclaim throttle after waking up the flusher.
> 
> The below test which used to fail on a 256GB system completes till the
> the file system is full with this change.
> 
> root@lp2:/sys/fs/cgroup/memory# mkdir test
> root@lp2:/sys/fs/cgroup/memory# cd test/
> root@lp2:/sys/fs/cgroup/memory/test# echo 120M > memory.limit_in_bytes
> root@lp2:/sys/fs/cgroup/memory/test# echo $$ > tasks
> root@lp2:/sys/fs/cgroup/memory/test# dd if=/dev/zero of=/home/kvaneesh/test bs=1M
> Killed
> 
> Cc: <stable@kernel.org>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Aneesh
