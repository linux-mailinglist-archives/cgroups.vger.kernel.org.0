Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF17B8CEA
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjJDTR7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244630AbjJDTR5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 15:17:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88A2CE;
        Wed,  4 Oct 2023 12:17:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso144530b3a.0;
        Wed, 04 Oct 2023 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696447073; x=1697051873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ELgqsOMecsnfYY/Zh/7I2mC+TPNVeHWk4zwTLsS3gI=;
        b=CUS6Jsm/DM9i5h+HagVzjdgzIICGkE4hcXX1nH3UJRz2ff6nYVCQjY5WCVUWWc8rbC
         9FJs+zsYbmEtJCyFzheKlkrRbX8agTdypAagGgm60s+Dmw23Aaqt3GAq3odfy8OwBwNF
         7X0EIFky4iJ1HOQF/43eEEbrhkpgCX5ocKMoBN4AiKoWwdC+yr6kjWUje2xIg6ojYCp3
         mQ3BAmA3u6fx1m9MLoNv+wn8NHiAmvaaYPzaEX/sHcgjfcPHSfDZ4YsNVynTi0/Lp+aX
         JU3yCza76pJzKgh/n96pi+mkUd4yDLWrqU9SKfUHrOiVgECrcYKyUjreoSqaAz2g+yEk
         aAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447073; x=1697051873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ELgqsOMecsnfYY/Zh/7I2mC+TPNVeHWk4zwTLsS3gI=;
        b=LKU0qjpVyzwGr/DrfRZ1PEQrrp2vTy7aogQJ7k0uP6HerrvkEHWxsqOTxRPQdMNqys
         yo/fERdDq358++30uh2ITPy1ZAdGOOjTBKK1s37MIj5YFpUZITtbl0v866kelYeq4jcA
         5EdhlqFHUkHXtaEp3Vc4raQIzGUBGMac9OSLdiYNm8C2wMjhGZmKE45pvG7K+ENXLFka
         u1VKLFNDi6wC6zD58tC5xTZD1sbQfTdX84w8GDeC2zrdlAGNZOrsoHTRKku3XCnTVf9h
         D61qNIHiFVTMI9Zy10rnoKymR6hAmbPHcaNoBc+wUw8erA+6v0qM7Xtkt9UCboNwG4st
         ckUg==
X-Gm-Message-State: AOJu0Yxwo0n2EAFWn9A+JaT/W5vN+i/7fw9hgWaczCKeKsocZ40vATTt
        Kq31ZipIGreq+kLo78k9KxA=
X-Google-Smtp-Source: AGHT+IE8uyANwVGnLow9zSZiiFgN0i4GjAlKVChwj+E22AvWzl6KM/h8H/frIev3CXgVexUqtkCR0A==
X-Received: by 2002:a05:6300:8095:b0:151:b96f:88b4 with SMTP id ap21-20020a056300809500b00151b96f88b4mr2832293pzc.23.1696447073054;
        Wed, 04 Oct 2023 12:17:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cef])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78714000000b0068842ebfd10sm3564296pfo.160.2023.10.04.12.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:17:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Oct 2023 09:17:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: In cgroup_no_v1() check v1 controllers only
Message-ID: <ZR26X4EJaNgQP5Be@slm.duckdns.org>
References: <20230920102513.55772-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920102513.55772-1-kamalesh.babulal@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 20, 2023 at 03:55:12PM +0530, Kamalesh Babulal wrote:
> cgroup v1 or v2 or both controller names can be passed as arguments to
> the 'cgroup_no_v1' kernel parameter, though most of the controller's
> names are the same for both cgroup versions. This can be confusing when
> both versions are used interchangeably, i.e., passing cgroup_no_v1=io
> 
> $ sudo dmesg |grep cgroup
> ...
> cgroup: Disabling io control group subsystem in v1 mounts
> cgroup: Disabled controller 'blkio'

So, making the printed names consistent makes sense but I'm not sure about
not matching "io" anymore. That's gonna break users who already use them,
right?

Thanks.

-- 
tejun
