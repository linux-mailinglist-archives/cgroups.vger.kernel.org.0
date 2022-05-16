Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA1528D4F
	for <lists+cgroups@lfdr.de>; Mon, 16 May 2022 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbiEPSml (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 May 2022 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiEPSmk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 May 2022 14:42:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C688626577;
        Mon, 16 May 2022 11:42:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so150081pju.1;
        Mon, 16 May 2022 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zfv6htmGomNEyvT4/mYlApRKn0/2gUiM5SY4HLzky7k=;
        b=GplBN0T/LVrKP/XISTvqaoVFkSl2pbtPN40wsW6anFajOkK7UTiSW3WGv0fnjcQtge
         50XorcIu8S0HDAV9BOZSwbaYiFQnVa5Z/HJ1NMUKSbyNIe5ItCma/u68lCrb+4UPAjFl
         y9wPtaO5MeIIIbzcyH4iAFLA09Qk2UWDtvuvZp027Alp0lHKdAw4kemili37K0stSiR2
         3d3352oB8pz/xXGjl4nFotNKezCb2+3/0ixz3zvuZft6aUqidrU/wRDgsiQJKAT/hW5x
         SRJkPGOsErEga1DSBQxzxT8bqsq8MC+l6DEqr1rI0j+d9R8R0kCwBDDMHHWJOhhaxM9F
         Y7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Zfv6htmGomNEyvT4/mYlApRKn0/2gUiM5SY4HLzky7k=;
        b=x0R4P8GefE1V+gpMDRfS3Q/yxr9+llQdhTR+cS75ZU+PJplTSAgfDbmGOLJyiVw8qu
         B1S7W84kEN85dBqQwlER9Q1K3NJpg7aBu8At/40/HI9dVkiBOn/CwMRh/38KCcin9pn0
         8GxcjjgLjWAJD1FmeA2k6aL+3NTcw1g33QXhEaSlPb5KLxDsSBmhEbAK9Qo2m0dpszGi
         dPwn+d3c2Vg+L0buhYskW0h7XE1fCzWNVbq5FQnTNHHGKfsjU1dmSunrdppYs7hiyGts
         PZyxtZ1SuVUbDE0q+LAOUoQrLwUpgqP81B/2f7T5XxO53Zihjaxxv4eBp/oU+3kNFqwF
         1wgg==
X-Gm-Message-State: AOAM533KzRxOJFuj0bFWHijyQ4PM21Q7pZywPk8DxlL0GdRrepyxykYc
        h8uTyZaIjQVzKqwYFUKrEPg=
X-Google-Smtp-Source: ABdhPJxxLmRRh4mwx4Je+VywjmM0/MA6lGqCCI7+JwRialjYsJhTyFP3bJxjcxAAUQbDGuX7/3+tDg==
X-Received: by 2002:a17:90b:3e8b:b0:1dc:e920:e072 with SMTP id rj11-20020a17090b3e8b00b001dce920e072mr32380827pjb.151.1652726559218;
        Mon, 16 May 2022 11:42:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id i9-20020a63e449000000b003c14af50622sm1789856pgk.58.2022.05.16.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:42:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 May 2022 08:42:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     bh1scw@gmail.com
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Message-ID: <YoKbHXZq5Knzl7LM@slm.duckdns.org>
References: <20220516173930.159535-1-bh1scw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516173930.159535-1-bh1scw@gmail.com>
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

On Tue, May 17, 2022 at 01:39:30AM +0800, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
> Which can serve as RCU read-side critical region, so remove
> rcu_read_lock/unlock().
> 
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
