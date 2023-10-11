Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C147C5DD9
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 21:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjJKTvH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Oct 2023 15:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjJKTvG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Oct 2023 15:51:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A56B9D
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 12:51:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a4fb3e096so234132276.1
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697053864; x=1697658664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+xtwxP2GC6kynmr5TxkkaN6Dd0EQSD998taM6zjmZM=;
        b=aH9SKfTjQQPm7zt5NpDoSSUrBv05JMJpjwuakeAh7Lqdm9ucO+spkUVIoQX4Tyie40
         Ke9qmroayCawzLLFFaeQizOk5TB1T0r5N8au45Hh1SP3IqrR7BHe3Itau4ZlPollbtLN
         GP/BS0yAaT+n9waIRYfTQXhcV7ZaNrjtgXkcUqSEbq4q9D3zRNiWlaDNfjU+W5JH3RG/
         z0DLm50Kyj1BNnfru9znffDzSgdwZI7EOZ5T31KXC10i04gyibFe2CKz98xIH7cFvPDa
         fkZD3m6Osomtu7uoGNPZcSq2JTIMD4GMDe6MZe/qfcD7n/O5VR/SxtpIbaf+FVXdUD5Z
         /sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697053864; x=1697658664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+xtwxP2GC6kynmr5TxkkaN6Dd0EQSD998taM6zjmZM=;
        b=LgoL8dw0ZFryNJZw3RnGGnkNMeMHDHUnrxma1FwHJLgx387Pyv0DWugMcmUxYn22uJ
         XmH07K1aW14KBUJBR0sGDpAboFUegISn4AvDhHrAK2CWtIaRxvAfiShnMtLoIGoHjeDN
         KURk5HsgyYEYJigsuT9+uWz4MVlZJupbFKPI7btddQF65ufptEtEJOQEwWcG9FtkK4UF
         eGBmLOULruA8OPr1Ik7aZgWW3ma0DUJOVLbCYk27sRLbEnKaEvSNN6YTtkHiQPNHRTI9
         Bi0m4DCNB2amOFy9nsdInh+l4YHNrPUMMknhQFOMapzMSeUNcHIe9e1VGh21u05Q4UgQ
         d80w==
X-Gm-Message-State: AOJu0YzggQX0tY4/Uz/Vm2dh0F6kEHgANXiVn6QEAt53nBWsGhHlF+9s
        kjfFJGAYgVwQRjWtGJiws0nQM6gz9FlFMQ==
X-Google-Smtp-Source: AGHT+IHjew1mpcUCKFj3tFkSQZF7ofzPnjUyZuwxOERyXzmESyX2Xjd1WD47puAaQY5ep5Qx7SzxUmEk0SOM2g==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:df45:0:b0:d9a:3e96:b549 with SMTP id
 w66-20020a25df45000000b00d9a3e96b549mr140481ybg.10.1697053864458; Wed, 11 Oct
 2023 12:51:04 -0700 (PDT)
Date:   Wed, 11 Oct 2023 19:51:02 +0000
In-Reply-To: <20231010000929.450702-4-roman.gushchin@linux.dev>
Mime-Version: 1.0
References: <20231010000929.450702-1-roman.gushchin@linux.dev> <20231010000929.450702-4-roman.gushchin@linux.dev>
Message-ID: <20231011195102.mym2mrgqyavp3n6r@google.com>
Subject: Re: [PATCH v2 3/5] mm: kmem: make memcg keep a reference to the
 original objcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 09, 2023 at 05:09:27PM -0700, Roman Gushchin wrote:
> Keep a reference to the original objcg object for the entire life
> of a memcg structure.
> 
> This allows to simplify the synchronization on the kernel memory
> allocation paths: pinning a (live) memcg will also pin the
> corresponding objcg.
> 
> The memory overhead of this change is minimal because object cgroups
> usually outlive their corresponding memory cgroups even without this
> change, so it's only an additional pointer per memcg.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeelb@google.com>
