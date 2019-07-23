Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D859F72290
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2019 00:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfGWWok (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 18:44:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40982 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfGWWok (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 18:44:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so21072520pls.8;
        Tue, 23 Jul 2019 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4y1txJPMDw45nI3k4swrjOtBVNsEnY/B83k42eCghwU=;
        b=ayaeacXt13mio966+juaFXXczu3VBG1Rqen8FWx+n6jXBQZqZG1lbGDSZD0nxOhhCI
         bBk1aEM3rtKuKZJJPJCjCkJFRV/Wp0P7FjxQGhmOneFd5q+MlCIxEtF7gyOJ1kbVar9J
         X5L+u4AxAcUiWY1TP4XBMl3P7VQdXWTD4PrN4lEysoAIqE+9yfG+c/L51ltiJFmbNHA1
         CK7y1Dlx+kPIGOhW2Td3kuEoCcmTdkstji8dP/tlUw/7RrcGcfEj2oUYGwbnn+FO0iYo
         ub99Dh+LURMxFPRkFBUcqufndeVEJ5UD6JcJHLvDM0okPnIQ3M8FTCxg0mE/vjgfRLZB
         f3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4y1txJPMDw45nI3k4swrjOtBVNsEnY/B83k42eCghwU=;
        b=WhM6VvLoN/09pCnH3c35u3BrswhMi+S4vI1ayepiG/bynkhbfezdIdrxJdaVrNOQwy
         ha1hO1u8NhOXxBTLlxZ7jaSisWcG0QWuudMXplDsatQ4l8Eu2ZgxKOerakg0G9Lv0BUH
         nXMlbK+Tv363sigCYaNUSkbUf0NYW53mqARlYexKiDLkSkA6+J9bNA+IqtePD4q2BL8Y
         q6lfnqxjWhrS3qd5Bejh3zKKPSiG7rU1faq8V1BuG/HB+dpsb42jR/avsAKx9L4sh/8R
         ubVbYUJuDbKt3Ryf73NukQ/hZuZITydbFx95cRJ3aOwV6skKC2vx9UPsQi5jv7CoGP0R
         FmbA==
X-Gm-Message-State: APjAAAW7ttS9vhDAHG2gThT3zBetU/3EfCQJuBp2N6o8JEUdDku4JOxJ
        4++BtBzM0NfATyoAUO67SmQ=
X-Google-Smtp-Source: APXvYqw2dEz7VNf5QtqzHB5ZQjzYooVHy/A9WTMvsO+whpmVq3VWNo4YgY9HOf3AhWY4PekXmUyF6A==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr82408185plb.269.1563921879327;
        Tue, 23 Jul 2019 15:44:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:2287])
        by smtp.gmail.com with ESMTPSA id o95sm38232391pjb.4.2019.07.23.15.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 15:44:38 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:44:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cgroup: Replace a seq_printf() call by seq_puts() in
 cgroup_print_ss_mask()
Message-ID: <20190723224436.GG696309@devbig004.ftw2.facebook.com>
References: <d465ca81-a870-b88c-0ea2-5e8bfbefb79d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d465ca81-a870-b88c-0ea2-5e8bfbefb79d@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 02, 2019 at 07:33:08PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jul 2019 19:26:59 +0200
> 
> A string which did not contain a data format specification should be put
> into a sequence. Thus use the corresponding function “seq_puts”.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to cgroup/for-5.4.

Thanks.

-- 
tejun
