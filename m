Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86516772DE2
	for <lists+cgroups@lfdr.de>; Mon,  7 Aug 2023 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjHGSaq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Aug 2023 14:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHGSap (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Aug 2023 14:30:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711FEE79;
        Mon,  7 Aug 2023 11:30:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso30963425ad.2;
        Mon, 07 Aug 2023 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691433044; x=1692037844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiHJQXFkmzKNYWpMVVoAzoC6rE61mLRbYTj0PtJL+pQ=;
        b=cuAvFn4RSNs15+vau2intXEcihC436GMRBGQTLwyeQ4LIRe1x1WJQ/ScHRiO6oE1ZR
         n0I0GkqIoFYHyBiiKKlxY3xfxtYcOES418LUmkTy8nom8MHp/NO8HgGPljBH/4ALZXdU
         zDy/pgyvU9SPF5f4GTXElkMV3rgZx4FvE6r06Jl9nBgBCBxMk7gEyv10x4k6j7ckgKQK
         Tz2p8w8Zix44AR/ISXFArXnVged/js6oleSs6o5iEo4on7TIg0YzazRVI9bpYTxJPsJo
         IO7NkJZaHQyAKpH0D8FPMnwgq57w2XlMuv1/ONdMvBAxi7/YebFN3YFpzdyCyaNNzZGv
         1upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433044; x=1692037844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiHJQXFkmzKNYWpMVVoAzoC6rE61mLRbYTj0PtJL+pQ=;
        b=Jz/TtOVF+2VEq8NMlmuszlT3GqPhhnUhtw/qddYdpXNplyMg9UNkpC4PST/UCYdumF
         BSV+e0PQnHWDb9JgPar0K+zHkFiiVwci1Ox9rBxg/E2rZuRm+JXL4pL3lZbzJiWeqKVM
         uv/YLiM1f8OvFnSsVaDA/gTwCIqZlBc53SRBTGX4lFszAGxxvfMBJK3uc4vjlXLjNOew
         KZ/8cvxPibrnZD2n9oNL3l0zB/wLd0O/zYUmXmxOO2y2edGq+Qz0smaTvFAZiMUAj8zS
         fQYN6Kj5hkETsSQ6LPdPq0XIbvJG+g007wvUgSKAiRdn2tjYEWqdz9MvWI/trONA3tOM
         OIvQ==
X-Gm-Message-State: AOJu0Yz0eyRPvI/hJWZnxCwTxLfLmF4iAKkAqO4sKgUxUP9psXGs2uxx
        4oGLuJJBAlKvhnoDZcpj7EE=
X-Google-Smtp-Source: AGHT+IFCd9jnoWig7LywjBcqf9kstbKXl3bA/Id8pX7m3q58clrO8M2JhOjPGh3zezq+8SwktBxyIQ==
X-Received: by 2002:a17:903:2289:b0:1bb:8f37:dd0f with SMTP id b9-20020a170903228900b001bb8f37dd0fmr9293832plh.45.1691433043781;
        Mon, 07 Aug 2023 11:30:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001bbb22652a4sm7232332plb.226.2023.08.07.11.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:30:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 08:30:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: clean up if condition in cgroup_pidlist_start()
Message-ID: <ZNE4Ubk44PY14Q6Z@slm.duckdns.org>
References: <20230807115831.3590631-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807115831.3590631-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 07, 2023 at 07:58:31PM +0800, Miaohe Lin wrote:
> There's no need to use '<=' when knowing 'l->list[mid] != pid' already.
> No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
