Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE335A30B4
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 23:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbiHZU70 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiHZU7Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 16:59:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA408E1148;
        Fri, 26 Aug 2022 13:59:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d12so2581771plr.6;
        Fri, 26 Aug 2022 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=67ANL95e8WHpoIL2CvpIV5IPIXCkv/6nKh73FiYEZTk=;
        b=biO0zryQaQSqyi8bDdtPfmAl9o+3iq97xCkOIKhxiVmKlGvcUduD2kqjuo/XihSovR
         jCmir/sMxqgFpUwGE0+obcQBUwULaZx+7azsdItRHZpaTPWwHoqQW5eMacjDaFjAfulm
         ZilurnwkbOupUHfy00vdLMFTXNYhvJbvdOcgwppj45evuV8NXTzcbaWHaFuIpvwS/xqh
         v84gT+m6Ht6e1jIEl6ojwrMfk39vFIakBip0EtwK4Hje+CuVM777pW79+8i1tteTosDP
         7k9qC/irsNCjfNM0i1se8cQZGpK+FwngOPznzHe73Te3w8eIJXnLeV6D/TFWuHnNkLfw
         J7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=67ANL95e8WHpoIL2CvpIV5IPIXCkv/6nKh73FiYEZTk=;
        b=ybP0ifdsCfKJCsxIBYwb5lPv5YaglOj6iVsHdszpbuT2rIJHxZ9hsKiSsHO89gJ0V3
         ISyyFYI0Ml3noA2vnuK6IT4sDRsDb4O2N1MVwpj6OTRB2ituV1lECvdfCvWW8QDNItyL
         G2GCthQ2J1QH/DJ9McgTbHB7HD6mxgz/uMyE7xZuukUSSLSYVzFjs5KYuNAzvGP0z9xV
         90ngPRMnC2GRfItex/67rvsvxmxF2AOygAQfEirI3TdYy6VyPGb4oBVsc/qJdDeir06z
         +FBQsbX9CRIyg4sjP2yK+z3dP3aOs5EUsayYoF8PUmG5eU3/va+yBVFI8RzDl4U6ISzA
         5Jvg==
X-Gm-Message-State: ACgBeo0U3r22a9j1cK9/+aipPKIN0e+0O3z02WfGBeUddw83K/Vb9ZU0
        aKZqViknhs2TduBFLndB5/A=
X-Google-Smtp-Source: AA6agR55DguAWBXsemZkDggBZ/fx1IG7675VyXBOjG+uW3E7KIJl6oRC/GTFcRTOz0hqDODPflJBFQ==
X-Received: by 2002:a17:90b:33d2:b0:1fb:971b:c5e9 with SMTP id lk18-20020a17090b33d200b001fb971bc5e9mr6111510pjb.90.1661547563042;
        Fri, 26 Aug 2022 13:59:23 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x14-20020aa79a4e000000b00537cfbb2810sm1695129pfj.65.2022.08.26.13.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 13:59:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 26 Aug 2022 10:59:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        bpf@vger.kernel.org, Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 0/4] Honor cgroup namespace when resolving cgroup id
Message-ID: <Ywk0KCmak/PsGfzL@slm.duckdns.org>
References: <20220826165238.30915-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826165238.30915-1-mkoutny@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 26, 2022 at 06:52:34PM +0200, Michal Koutný wrote:
> Cgroup id is becoming a new way for userspace how to refer to cgroups it
> wants to act upon. As opposed to cgroupfs (paths, opened FDs), the
> current approach does not reflect limited view by (non-init) cgroup
> namespaces.
> 
> This patches don't aim to limit what a user can do (consider an uid=0 in
> mere cgroup namespace) but to provide consistent view within a
> namespace.

Applied 1-3 to cgroup/for-6.1. The branch will be stable, so please feel
free to pull from bpf/for-next.

Thanks.

-- 
tejun
