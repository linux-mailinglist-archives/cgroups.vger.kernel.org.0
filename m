Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22C27B8E13
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjJDUbL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 16:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244982AbjJDUbK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 16:31:10 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94749C1
        for <cgroups@vger.kernel.org>; Wed,  4 Oct 2023 13:31:02 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7740c8509c8so14609485a.3
        for <cgroups@vger.kernel.org>; Wed, 04 Oct 2023 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696451461; x=1697056261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXYkNNwyK1dpfEtHp9sOFR0NjxTumXuiYxFY0CQML8E=;
        b=Yb/yLZ/lSKqCcNTFd0++jfe7LwtA1e2a8fxeowPvo/ZqVvAxCu+eFjSfwtxq4GwSp0
         qQ1jy/fxuFb1yaqaYa/1Bi1CvsCNRFEaFo7kHIcJu1+M/U+xfJ3IqjFmPw1VhpAoPDfp
         Nfd1qFtaYZ1veD5XH8E6d/9JxtzEc4pQAwljQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696451461; x=1697056261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXYkNNwyK1dpfEtHp9sOFR0NjxTumXuiYxFY0CQML8E=;
        b=oq1pJh6eMO2XndJ8HeQoqTRYYFNjjkrt0OwYJqbl4Qbc1G05od3vq4jDLjzymrEawM
         fCHv4hgHkoCM9eQSV/AnhUDqX4PfNmo5MnwvYQXeWC4mtNK2Isl0+zxGL6b4Agl9+nXx
         gW7ArxY9oIKq2h7iZIEa5SIS7pq7rPokb7iVKqYUK0GbZ8xHBdajq9D2w46BEuGM8r5j
         XQfmFWlC+Z0Vpk78rxtBEylMb2LkJ1zLtBcIUYDDa+jJSSQVMx09GEC9oK51L3E9W5qm
         +DeruFkgQcUWw15UpVIPCtTsV4I1DORBfVBAQR+HKiUOCZUa5AaKGHWVBJ9hmVXojc7W
         Mgxg==
X-Gm-Message-State: AOJu0Yw7OXJcGSnjQUyJDLT4QCn6KMcYfXFgBelfbcWc77VKDfFUBf7X
        gUYZN1jQFQnUd0LlmmQTLrqrCs6KZrr0E9HRp81ImQ==
X-Google-Smtp-Source: AGHT+IGLZP33HnZS7bG9xtyaa74P8ZAeBNdPd6PgpTcqRfaa7OqDoemhVNJ3IZ0HDt0/MrPs8ICW6w==
X-Received: by 2002:a05:620a:908:b0:767:e993:5702 with SMTP id v8-20020a05620a090800b00767e9935702mr3401179qkv.35.1696451461307;
        Wed, 04 Oct 2023 13:31:01 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id s14-20020ae9f70e000000b00774309d3e89sm1512300qkg.7.2023.10.04.13.30.59
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:30:59 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-419768e69dfso94581cf.0
        for <cgroups@vger.kernel.org>; Wed, 04 Oct 2023 13:30:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1a92:b0:419:6cf4:244f with SMTP id
 s18-20020a05622a1a9200b004196cf4244fmr64519qtc.20.1696451458698; Wed, 04 Oct
 2023 13:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com> <ZR29mvoQMxcZcppw@slm.duckdns.org>
In-Reply-To: <ZR29mvoQMxcZcppw@slm.duckdns.org>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Wed, 4 Oct 2023 13:30:44 -0700
X-Gmail-Original-Message-ID: <CACGdZYLFkNs7uOuq+ftSE7oMGNbB19nm40E86xiagCFfLZ1P0w@mail.gmail.com>
Message-ID: <CACGdZYLFkNs7uOuq+ftSE7oMGNbB19nm40E86xiagCFfLZ1P0w@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Tejun Heo <tj@kernel.org>
Cc:     linan666@huaweicloud.com, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 4, 2023 at 12:32=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Sep 28, 2023 at 09:58:58AM +0800, linan666@huaweicloud.com wrote:
> > From: Li Nan <linan122@huawei.com>
> >
> > When the throttle of bps is not enabled, tg_bps_limit() returns U64_MAX=
,
> > which is be used in calculate_bytes_allowed(), and divide 0 error will
> > happen.
>
> calculate_bytes_allowed() is just
>
>   return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
>
> The only division is by HZ. How does divide by 0 happen?

We've also noticed this - haven't looked too deeply but I don't think
it's a divide by zero, but an overflow (bps_limit * jiffy_elapsed / HZ
will overflow for jiffies > HZ). mul_u64_u64_div_u64 does say it will
throw DE if the mul overflows

>
> Thanks.
>
> --
> tejun
