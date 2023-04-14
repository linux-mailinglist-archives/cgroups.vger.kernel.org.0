Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9C6E28CC
	for <lists+cgroups@lfdr.de>; Fri, 14 Apr 2023 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDNQ4j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Apr 2023 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjDNQ4i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Apr 2023 12:56:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46244AA;
        Fri, 14 Apr 2023 09:56:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y6so17807431plp.2;
        Fri, 14 Apr 2023 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681491396; x=1684083396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28gmcAD8PpsVn0NwYwDOiW5yvJVzcaxRIYUggc0qigE=;
        b=p89rqc7JEr8KC8lByaaP0wofLPfeCULMVuVP7rIrDf7Bx2RMx3fHLJUANRpxiDTpjE
         SB7B2GuIkm85rEwraw3xvRmWMLsggNJFeJT6gue9xZ5iiWXB/I4pO+YKtLQNYb3QcI0K
         CMaebrdPWnZv2Fdi45ddcvE/7RSg6HzKjgdQSe8TG5pYoB8/TRyHSPjjKUUselaneY7y
         Fzsgbv79qyr+VQr8YgSO4ifpqmXNeiyY5VML9raEAkqZhKGPIKJdhOIASvrhSv8swE8T
         dOTpF69gWN9lih0IcxfB4MCkhiSue3Y2kPDYQlLK+7Y1mYWuUQmGUKMhbKC6MCqu+2Hu
         8x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681491396; x=1684083396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28gmcAD8PpsVn0NwYwDOiW5yvJVzcaxRIYUggc0qigE=;
        b=DbjMrTq4wKmUE9i0vU5L3FPcdZZG9dMMUITV6gugKMPqHK52VlziePXwDL0N/4fLoo
         jq4oNNAG5oQNuJxNXaDSgyIrxD0qX86XgWzi4bGFRV7Dr0XQNdCwEK+TGGB1QhCQM/bL
         NOgBKPSvJM4mXJwdTrZrBGVhlE94NgayxCJoIJAK2LregLeJS71n1fjEmbagGXLJkftu
         bUXJQizmEhU2+ipCmcf2wd9TiRe1UBP1dYy3MWCNmxvwbItkcIFEdRXtm5/5d9tDMOaX
         rsZRvJ/iix7amrGPl/wSRuBtxH2EQLqOcTZMsZIlm++iSeG+Ktk9XKx329xsSofvTELN
         5mog==
X-Gm-Message-State: AAQBX9e7GsY67CptRcuhXeoJ+g+vf8G67mYeof1GEK3Yib03RHkk8Yem
        L/lSOmwo2VS8vAWL2UpEJ4A=
X-Google-Smtp-Source: AKy350bRSdjLR/XP2NsmSn+x4cWxqk+Sn/VZCjCK903lGYxtEE/+YnwGQ+ChpPkpXUU2cDwhI8zDig==
X-Received: by 2002:a17:902:e74c:b0:1a6:6b9c:48ae with SMTP id p12-20020a170902e74c00b001a66b9c48aemr4330798plf.52.1681491395273;
        Fri, 14 Apr 2023 09:56:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001a2445d9a41sm40025plg.141.2023.04.14.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:56:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 14 Apr 2023 06:56:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: cgroup-v1/cpusets: update libcgroup project link
Message-ID: <ZDmFwYUmVUyKEjQE@slm.duckdns.org>
References: <20230414054849.320414-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414054849.320414-1-kamalesh.babulal@oracle.com>
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

On Fri, Apr 14, 2023 at 11:18:49AM +0530, Kamalesh Babulal wrote:
> Update the libcgroup project link, in the cgroup v1/cpusets
> documentation.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Applied to cgroup/for-6.4.

Thanks.

-- 
tejun
