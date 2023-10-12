Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F17C74DF
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379616AbjJLRgd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347449AbjJLRgU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 13:36:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00061BD;
        Thu, 12 Oct 2023 10:24:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692ada71d79so1036368b3a.1;
        Thu, 12 Oct 2023 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131441; x=1697736241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6IdNqkJlQ5b34MhEcWXMstxhdqRUJGV879MZSa7cwM=;
        b=U8xvm1GcLgVqTAarHA/Uo+VaQHjpUY6cNFP3AAFy39ASiP6z0DSg4VrbSI6VzfYBwd
         Rcpt9vUq2SiQCaEMRU9UhPMZ59EGxb/WEOg8Xbj4qHyDXhoz0dR6iXqwEcDbnk+D5BSy
         BmanzzrMsoOGQSQtPfw0MkVMeIfMteMg3fPp5DTiQvPbHE8lHkZ6gbmeAxF76OD3HBpS
         4ElItdG2Nrhxf9TD/Kxwqmz6gfzA8hpTlSEaNLdZCKDz+Y1YpPA5rMvQVcJ/hxL5P0pw
         IA5yfXov6v2YCjZIIjHscOEXpy3XwSXm9ArR+3Pd+nlMnMCCSJs57UyrO8Cd36qCbCsB
         zYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131441; x=1697736241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6IdNqkJlQ5b34MhEcWXMstxhdqRUJGV879MZSa7cwM=;
        b=aj671nF6xYakYjyhkermJg1H9Q2nEyHaKq5Kyl4eJCN4ba+GYTBpSfeXOHTE44tu96
         ul9hO5RbUd3BujOzpgJTEFY327NtkkNGeK/y+xSqcMUSp6t95dnz8jG9xdZZ6yW0LybK
         03NQHBIPjYR1IoS0ZSGa6TEkqc7OtiSoJvwpot9wYkdoq1OwWq8jZd7hCwO0Pw8qKyfg
         aUcI9xS0w9QRfgVj2/YpAlcfeblg3r0vzz4JnvBW23CjDwhcrnqx7p2m/Q2JLri57UZU
         yt6DxcY1MXlqjrNJhhGgBsYR0XJg4KcECK28XQdlM8Fch+22V/JVuZuL0M+XHeiYeYmh
         99YQ==
X-Gm-Message-State: AOJu0Yw/lPQ7xJGsrpXTmNUQfqZy3BLrtfqIegY7DRH2oXzQCuqHovwp
        bbJANV47ieeWfU9ja9sYc8nTsBFi0xdTuw==
X-Google-Smtp-Source: AGHT+IEoPLPZPNpn0PaF/1GkdqkaHVgyx4TX0K8LDk6dfofoi19xckq2FfD+ghEElOBNiMudTS8feQ==
X-Received: by 2002:a05:6a00:1781:b0:690:2e46:aca3 with SMTP id s1-20020a056a00178100b006902e46aca3mr27681958pfg.25.1697131440758;
        Thu, 12 Oct 2023 10:24:00 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b0068c90e1ec84sm12110894pfm.167.2023.10.12.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:24:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Oct 2023 07:23:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix incorrect css_set_rwsem reference in comment
Message-ID: <ZSgrr0uRZjQSD8de@slm.duckdns.org>
References: <20231012170902.3448834-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012170902.3448834-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 12, 2023 at 01:09:02PM -0400, Waiman Long wrote:
> Since commit f0d9a5f17575 ("cgroup: make css_set_rwsem a spinlock
> and rename it to css_set_lock"), css_set_rwsem has been replaced by
> css_set_lock. That commit, however, missed the css_set_rwsem reference
> in include/linux/cgroup-defs.h. Fix that by changing it to css_set_lock
> as well.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.6-fixes.

Thanks.

-- 
tejun
