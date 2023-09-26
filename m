Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D457AF2BC
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 20:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjIZSZb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 14:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbjIZSZ2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 14:25:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C59136;
        Tue, 26 Sep 2023 11:25:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690d9cda925so7314401b3a.3;
        Tue, 26 Sep 2023 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695752721; x=1696357521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mL/CHvcHgJZFxYJYLpsg7SBW9N36wXwuTr+5AxMKYEM=;
        b=E2ybVHOyKLtxteKkfHFCaEm8gRch9Pcx2ISqkNoq7pKtr6YRNebHLvtW2TXYfI+S/T
         Loef4K8pn2F/umiQEIKFbsCxfCs/m+B7/nI3UuEpu6xJvwRkTqw5w4cLmd0OHL1okRPi
         VUVi0OWVygIRga+Nuv5SqEQZlL8y0e9CbAD959hUWppZyphBQawOSp2iXGR1CYswq9ku
         oHl8NfgH1GMb8fzhbXi73IFV3xHpdDKEFHh5h7Q8Rjpxa2XvDCgYa3M5vGndjfxWd/0v
         ElUt9lr+gXLeIPNcwI6agw0vR18mDSfWruM753eI9wxxH6kxw3Gf9EMqyeYFuW+dexid
         Prcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752721; x=1696357521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL/CHvcHgJZFxYJYLpsg7SBW9N36wXwuTr+5AxMKYEM=;
        b=G7p+4+IhraYECOBS1vlHwn72irjNfZiCg34ztbjuIERnOrQDnCPR5st8+SFyQgSBbj
         M1nsN0MLSYPnTtRyo9ga8bd31Yf2mMZm/1tT1Ra9umBL1nq7Vw1hoPelkQ9kosuSICgG
         7RkRoj0kc8MRaUMjlzhMr1buocyaXG8eNLqh2Ma7fqAbv+GExGRViRRxjNEoqNeJEhq2
         EAFr3lZ7r2wq7SnugkOysGz7RI1s04KQgtagb94XnmdHlhDsTGQgaeOlVXyT2eZL+O34
         A+ZGs/5EamEK13IEx6614jRfz6P3zLMjcsOCXAFCyempxVmDjFmNBcZ2JS1wCiVrzMxb
         tIMQ==
X-Gm-Message-State: AOJu0YzA8xHn6LxeGsrGDFlrC8aw5SJ8HtE1kiWwkxjoEyrKexjoEaEP
        BcPARptORFfNfVESYVdO+rknKhUlaVDIJA==
X-Google-Smtp-Source: AGHT+IGwqu5jXLn7iFSLyPz8LErf6nFqrlKwCsOwTqnm3SpYPcIQZ40TIJbwamFkfV/7oSxlMmB3iw==
X-Received: by 2002:a05:6a00:1249:b0:692:b6e8:ce88 with SMTP id u9-20020a056a00124900b00692b6e8ce88mr8328168pfi.17.1695752721060;
        Tue, 26 Sep 2023 11:25:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:dfcd])
        by smtp.gmail.com with ESMTPSA id fk1-20020a056a003a8100b00682868714fdsm10674491pfb.95.2023.09.26.11.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:25:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Sep 2023 08:25:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add bpf support for cgroup
 controller
Message-ID: <ZRMiDwYF8yDookLf@slm.duckdns.org>
References: <20230922112846.4265-1-laoar.shao@gmail.com>
 <ZQ3GQmYrYyKAg2uK@slm.duckdns.org>
 <CALOAHbA9-BT1daw-KXHtsrN=uRQyt-p6LU=BEpvF2Yk42A_Vxw@mail.gmail.com>
 <ZRHU6MfwqRxjBFUH@slm.duckdns.org>
 <CALOAHbB3WPwz0iZNSFbQU9HyGBC9Kymhq2zV83PbEYhzmmvz4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbB3WPwz0iZNSFbQU9HyGBC9Kymhq2zV83PbEYhzmmvz4g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Sep 26, 2023 at 11:01:08AM +0800, Yafang Shao wrote:
> Thanks for your suggestion. I will think about it.
> BTW, I can't find the hierarchy ID of systemd (/sys/fs/cgroup/systemd)
> in /proc/cgroups. Is this intentional as part of the design, or might
> it be possible that we overlooked it?
> In the userspace, where can we find the hierarchy ID of a named hierarchy?

Yeah, /proc/cgroups only prints the hierarchies which have controllers
attached to them. The file is pretty sad in general. However,
/proc/PID/cgroup prints all existing hierarchies along with their IDs and
identifiers (controllers or names). Hopefully, that should be enough?

Thanks.

-- 
tejun
