Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E94C003E
	for <lists+cgroups@lfdr.de>; Tue, 22 Feb 2022 18:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiBVRkJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Feb 2022 12:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiBVRkJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Feb 2022 12:40:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7F166E12
        for <cgroups@vger.kernel.org>; Tue, 22 Feb 2022 09:39:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q11so6439671pln.11
        for <cgroups@vger.kernel.org>; Tue, 22 Feb 2022 09:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3dt3gz8kjCoy+zOLuGXFrGoSXvvg7jhT72pRPC3cAmo=;
        b=CPCIZ08cqqxPYNocoFg/gQk550OLi0J1HgIIbzDPu4K3LBtAsnMcCU3fU5O8jraCte
         JC/aQ/phgl2NgereqZkj6ybN/iD0UOSZqRCAYploTleZ6pHDl0LELYc/R8iK9Q7gDhfh
         kzRVaLQ5JNK4LMgcJsQYuCUcMvDHj9AYs+UsenezC8i8gIZkbZ4m7tcvl7ficrC0S9pm
         WaFibbjPRIzZhoKishx/M5kqKQoK5Py4pjd7qYJ5ieQZ2wCQdtGsMo3LE9l7TAXfHQf+
         cEA5H7lMVhVYMVl68Dq2Mo3qs5+EfSNvWu4qMhSVCoXzAT0S6R4J1dOHBu5MmvwCauy1
         v6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3dt3gz8kjCoy+zOLuGXFrGoSXvvg7jhT72pRPC3cAmo=;
        b=K4Trj1iYka3B1Dw919O3sZyDV25dr3rA6zoXgVdq1FXVWb57lcrtTkFsHXSpzOqDFx
         YKw1i4zgL1TZvGsrleJYsz+cagKlPRakSMetxZx1p0jEJmmErStIsOcTdS8jgR87ilUo
         j9XP4c6wKyY5oqEyG/LY9Cw3i0GP1zfEdos9YWoZkCtJY9QufVkl3JY6pBZiqIoe8hft
         a1JfE7PMUNHfJZtJLjPq6jpSqwSvLIzgdMjERmvehgdDWqPX26zzMajCYCL0pi30xhlw
         p9L5d8MArcUvtUvAaURRhgjwjn8kGiMRWrXNW3fi81mW6k/JKi9hB1cHd/oBrKecgVwh
         rn4A==
X-Gm-Message-State: AOAM5310eXpmG0JNvTMfLfeC/V/lfdh7p0yl/MK5A2xXNfRF4np0E5UQ
        Occ4zvRWmKyIT7IEcBFxeya98j+/Tus=
X-Google-Smtp-Source: ABdhPJx8r/4gfQZJzfH1YnZL4NBFd0YyCvjlbl1xxoJ54EIl+/fQY6waJQ0jDZbAk+Xs88zOD6VHIQ==
X-Received: by 2002:a17:902:8504:b0:14f:501:4caa with SMTP id bj4-20020a170902850400b0014f05014caamr23887350plb.93.1645551583220;
        Tue, 22 Feb 2022 09:39:43 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p16sm18994114pfh.89.2022.02.22.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:39:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 07:39:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: clarify cgroup_css_set_fork()
Message-ID: <YhUf3QuwB9aHT60i@slm.duckdns.org>
References: <20220221151639.3828143-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221151639.3828143-1-brauner@kernel.org>
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

On Mon, Feb 21, 2022 at 04:16:39PM +0100, Christian Brauner wrote:
> With recent fixes for the permission checking when moving a task into a cgroup
> using a file descriptor to a cgroup's cgroup.procs file and calling write() it
> seems a good idea to clarify CLONE_INTO_CGROUP permission checking with a
> comment.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: <cgroups@vger.kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Applied to for-5.17-fixes with cosmetic changes.

Thakns.

-- 
tejun
