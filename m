Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE1E756C48
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGQSjg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjGQSjZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 14:39:25 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9C0C0;
        Mon, 17 Jul 2023 11:39:24 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78362f57500so263605839f.3;
        Mon, 17 Jul 2023 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689619164; x=1692211164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw4pfToCDzbwKl5whorLOvvLRVs7p/9il+TGwrm7FW4=;
        b=WbCf7Pvxbd5alM4qarjJypY0xX0G2HGUACwFvzhosxjp9f2/b9QcbmhAf1i2D2b+8q
         Kj0Qyr843i2e35Pd3EjxM8eWpncjATlCOKkc2sOwGVaCV59Uqa3mF0YZ+4XZp7o705kE
         8jUGbw/LYWab5l5dBzhRyKfykFo7EJst/cC7TBeLm0ZkyImUZTZNWCBG4bBAQhpg6urv
         gDI0HZiWpAmlecMbCK21cJmpWHZnu6J/gbQ7LHzMCSfx+BQAlM6JdBD0+6eaaiJEy000
         VcdpPrsqSTKn2gLgI+Simyj1PwohqhlxcZemESymq0ECseqziwcSHS2DxgeyZtMO3YPq
         eSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689619164; x=1692211164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw4pfToCDzbwKl5whorLOvvLRVs7p/9il+TGwrm7FW4=;
        b=QtHK0HKz3fcTct8DDn8Q8avGqTdtk2bxxzhWw1WFhRO4Cw0hToccFdZD82trVQNmxd
         geYwoN8pnRi3iMSBjjaolnW37cHGdGCDJNqY5t9vKfR8i5wE7jRz0wwyqUewMWk4/dOG
         cBQlUX4CQhvm6oLK863cCWP71vUv+R2N/u+feZ7MfyUQg4FVQe9d5jYOsHhTCAQDXDKc
         kvQ7W/JQhAmBrrIWkh65Y2G+67FwG6cS/dhXNdkrqlb60a5oFZIDv3CabLksKqwEjWlR
         VKtaItiXAvPdPCKI9JGf3o41AVdUOjIoKKPCWME73e+OpfoeNN31C6PZ7LBe6Y7gebjQ
         rgfg==
X-Gm-Message-State: ABy/qLbIeJ6sCgLu0fzMuF7ugVjNsa86zs9ATr6K3JssvgeOxyTy8MFF
        myC4VIUu0wfsFquaTU8+oF8=
X-Google-Smtp-Source: APBJJlFZfZTN/6UyVJpcgaA2l1NABh19TDAFnCkx4lHehs/IxDNeBuf1zr28OIrts53nQp0FcSxn/Q==
X-Received: by 2002:a5d:80c4:0:b0:786:f10e:a473 with SMTP id h4-20020a5d80c4000000b00786f10ea473mr443258ior.16.1689619163980;
        Mon, 17 Jul 2023 11:39:23 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id h3-20020a056602008300b0077e3566a801sm30631iob.29.2023.07.17.11.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:39:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Jul 2023 08:39:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix obsolete function name
Message-ID: <ZLWK2q9OVath4J05@slm.duckdns.org>
References: <20230717112800.2949233-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717112800.2949233-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 17, 2023 at 07:28:00PM +0800, Miaohe Lin wrote:
> cgroup_taskset_migrate() has been renamed to cgroup_migrate_execute() since
> commit e595cd706982 ("cgroup: track migration context in cgroup_mgctx").
> Update the corresponding comment.

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
