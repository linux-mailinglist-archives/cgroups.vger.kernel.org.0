Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA4F7B8646
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbjJDRSc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjJDRSb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 13:18:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE58AB;
        Wed,  4 Oct 2023 10:18:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c60a514f3aso19000385ad.3;
        Wed, 04 Oct 2023 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696439908; x=1697044708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+L+GSCOF/70j5QTPg78IQxFAzwzFud8rAzHLyG8ZaM=;
        b=d+7qG9DPkCmy3PRA5HwSbSyojQA8GcY59QcnLG8TQWFIm8QdcBDVCIpJFtmh5psjYf
         aF7LAW5zcEh0fIfPgwhXu15slUnVufPLuPtugiQ73tZawQvCh+zMZ8geQ2qEFNIeBb5k
         v8B4Zq16KhDkzMDd4hzSBo9Dxh6cg9jBCTGpwB3VRcvfmHSwXJ6E+M5eVD4eIB7j/0HQ
         8j0iFG+R0uHzsKcFHeN496Qmft7xCQ9MXtOtmU77VYgb7u/GsDOuFRvqTFlBE0MefMQd
         ygU2v6lHG/arARG9p/a9gNJyV0ShkbPGstpsWF9PLc1vq7wvVzVx+3xFcfzQWdj7UYPk
         RK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696439908; x=1697044708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+L+GSCOF/70j5QTPg78IQxFAzwzFud8rAzHLyG8ZaM=;
        b=huxqExjoTl0g8/y3J9Z05Kg+3vELvQ47H+1ADmM89lZK6AghC1UFPRQNhqD+b+Wyvg
         JOyIS7ip89Up8GrjsQgF8jsQmGCWpSmqRY+t69Yz68dtvRNHmiDqn6+KAurfyZXB5tFB
         TTaNZ461bvY4eDWQlqDI0eAkq7rjDk0G+nI/6XucfVR1Qlz932ZsDh2ucrcY/NURS+BW
         yiETa437SrwxWIZegq1Yb12KMtHtu21iUIBWt9aUhVh0h8cjH6ug2cQkIS2xE48A3J+z
         +kGIdWuwVQ7HAr8266tAmc8jl6iwbYlLCNiujn1XC3hUJbwp1KVzFzSXGUHgBBzFfnIl
         /pjQ==
X-Gm-Message-State: AOJu0Yz8M8eX3c/cl08Tk2jVG5+6djUoM9iUGunLGA3PMstQ3rh7Zz5b
        a9v337CaiLuq9MV3dDygT5g=
X-Google-Smtp-Source: AGHT+IH9/qymEfnLixMr37Go2E/Ci9z1JbZZkJLBLNgvVh5yJK4UeNUCz5JI6nvjM81CnG9QZkCAaA==
X-Received: by 2002:a17:903:248:b0:1c7:495c:87e0 with SMTP id j8-20020a170903024800b001c7495c87e0mr3089322plh.37.1696439908317;
        Wed, 04 Oct 2023 10:18:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cef])
        by smtp.gmail.com with ESMTPSA id ju4-20020a170903428400b001c73f3a9b7fsm3985474plb.185.2023.10.04.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:18:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Oct 2023 07:18:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, zhiquan1.li@intel.com,
        kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
        yangjie@microsoft.com
Subject: Re: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
Message-ID: <ZR2eYoPZpuU-0QIT@slm.duckdns.org>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-2-haitao.huang@linux.intel.com>
 <CVS5XFKKTTUZ.XRMYK1ADHSPG@suppilovahvero>
 <op.2buytfetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CVSVH3ARQBRC.1QUTEQE3YNN5T@qgv27q77ld-mac>
 <CVSVJ8DYAME8.SMTH7VYG7ER@qgv27q77ld-mac>
 <op.2bwqct0rwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CVYBI76N4PTF.38BQ9KIBIOGEH@seitikki>
 <CVYBO2F1D1NC.1N7LNWPTDRG04@seitikki>
 <op.2cardibgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.2cardibgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Oct 04, 2023 at 10:45:08AM -0500, Haitao Huang wrote:
> So I will update to something like following. Let me know if that's correct
> understanding.
> @tj, I'd appreciate for your input on whether this is acceptable from
> cgroups side.

Yeah, that's fine by me and I can't tell what actual differences the two
would have in practice.

Thanks.

-- 
tejun
